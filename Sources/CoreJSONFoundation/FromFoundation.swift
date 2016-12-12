/**
 *  CoreJSON
 *
 *  Copyright (c) 2016 Tom Quist. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation
#if SWIFT_PACKAGE
    import CoreJSON
#endif

/// Transforms output of Foundations JSONSerialization into JSON
extension JSON {
    
    public enum FoundationTransformationError: Error {
        case unsupportedValueType(Any)
    }
    
    private init(foundation dict: [String: Any]) throws {
        var objectProperties = [String: JSON]()
        try dict.forEach { (key, value) in
            objectProperties[key] = try JSON(foundation: value)
        }
        self = .object(objectProperties)
    }
    
    public init(foundation value: Any) throws {
        switch value {
        case let optional as OptionalType where optional.isNil:
            self = .null
        case let string as String:
            self = .string(string)
        case let number as BoolConvertible where number.asBool != nil:
            self = .bool(number.asBool!)
        case let number as NSNumber where value is Double: // Only on ios/osx we can bridge numbers to double and NSNumber
            self = number.json
        case let float as Float:
            self = .number(.float(float))
        case let double as Double:
            self = .number(.double(double))
        case let uint as UInt:
            self = .number(.uint(uint))
        case let uint as UInt64:
            self = .number(.uint64(uint))
        case let int as Int:
            self = .number(.int(int))
        case let int as Int64:
            self = .number(.int64(int))
        case let number as NSNumber: // This case will only be reached on linux
            self = number.json
        case let object as [String: Any]:
            self = try JSON(foundation: object)
        case let array as [Any]:
            self = .array(try array.map(JSON.init))
        default:
            throw JSON.FoundationTransformationError.unsupportedValueType(value)
        }
    }
    
}

extension NSNumber {
    
    private static let trueNumber = NSNumber(value: true)
    private static let falseNumber = NSNumber(value: false)
    private static let trueObjCType = String(cString: NSNumber.trueNumber.objCType)
    private static let falseObjCType = String(cString: NSNumber.falseNumber.objCType)
    
    fileprivate var isBool:Bool {
        get {
            #if !os(Linux)
                let objCType = String(cString: self.objCType)
                if (self.compare(NSNumber.trueNumber) == .orderedSame && objCType == NSNumber.trueObjCType)
                    || (self.compare(NSNumber.falseNumber) == ComparisonResult.orderedSame && objCType == NSNumber.falseObjCType){
                    return true
                }
            #endif
            return false
        }
    }
    
    fileprivate var json: JSON {
        if isBool {
            return .bool(boolValue)
        }
        #if !os(Linux)
            if let objcType = String(validatingUTF8: self.objCType) {
                switch objcType {
                case "B", "c": return .bool(boolValue)
                case "i", "l": return .number(.int(intValue))
                case "I", "L": return .number(.uint(uintValue))
                case "q": return .number(.int64(int64Value))
                case "Q": return .number(.uint64(uint64Value))
                case "f": return .number(.float(floatValue))
                case "d": return .number(.double(doubleValue))
                default: break
                }
            }
        #endif
        return .number(.double(doubleValue))
    }
}

/// Types that can potentially be converted into Bool
fileprivate protocol BoolConvertible {
    var asBool: Bool? { get }
}


extension NSNumber: BoolConvertible {
    
    fileprivate var asBool: Bool? {
        switch json {
        case let .bool(bool): return bool
        default: return nil
        }
    }
    
}

extension Bool: BoolConvertible {
    var asBool: Bool? {
        return self
    }
}

fileprivate protocol OptionalType {
    var isNil: Bool { get }
}

extension Optional: OptionalType {
    fileprivate var isNil: Bool {
        if case .none = self {
            return true
        }
        return false
    }
}

extension NSNull: OptionalType {
    fileprivate var isNil: Bool {
        return true
    }
}
