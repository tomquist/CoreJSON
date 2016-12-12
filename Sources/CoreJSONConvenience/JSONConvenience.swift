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
#if SWIFT_PACKAGE
    import CoreJSON
#endif

extension JSON {
    public var isNull: Bool {
        switch self {
        case .null: return true
        default: return false
        }
    }
    
    public var isBool: Bool {
        switch self {
        case .bool: return true
        default: return false
        }
    }
    
    public var isNumber: Bool {
        switch self {
        case .number: return true
        default: return false
        }
    }
    
    public var isInt: Bool {
        switch self {
        case .number(.int): return true
        default: return false
        }
    }
    
    public var isInt64: Bool {
        switch self {
        case .number(.int64): return true
        default: return false
        }
    }
    
    public var isUInt: Bool {
        switch self {
        case .number(.uint): return true
        default: return false
        }
    }
    
    public var isUInt64: Bool {
        switch self {
        case .number(.uint64): return true
        default: return false
        }
    }
    
    public var isFloat: Bool {
        switch self {
        case .number(.float): return true
        default: return false
        }
    }
    
    public var isDouble: Bool {
        switch self {
        case .number(.double): return true
        default: return false
        }
    }
    
    public var isString: Bool {
        switch self {
        case .string: return true
        default: return false
        }
    }
    
    public var isArray: Bool {
        switch self {
        case .array: return true
        default: return false
        }
    }
    
    public var isObject: Bool {
        switch self {
        case .object: return true
        default: return false
        }
    }
    
}

extension JSON {
    
    public var boolValue: Bool? {
        get {
            switch self {
            case let .bool(boolValue):
                return boolValue
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .bool(newValue)
            } else {
                self = .null
            }
        }
    }
    
    public var intValue: Int? {
        get {
            switch self {
            case let .number(.int(intValue)):
                return intValue
            case let .number(.uint(uIntValue)):
                return Int(uIntValue)
            case let .number(.float(floatValue)):
                return Int(floatValue)
            case let .number(.double(doubleValue)):
                return Int(doubleValue)
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .number(.int(newValue))
            } else {
                self = .null
            }
        }
    }
    
    public var uintValue: UInt? {
        get {
            switch self {
            case let .number(.int(intValue)):
                return UInt(intValue)
            case let .number(.uint(uIntValue)):
                return uIntValue
            case let .number(.float(floatValue)):
                return UInt(floatValue)
            case let .number(.double(doubleValue)):
                return UInt(doubleValue)
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .number(.uint(newValue))
            } else {
                self = .null
            }
        }
    }
    
    public var floatValue: Float? {
        get {
            switch self {
            case let .number(.int(intValue)):
                return Float(intValue)
            case let .number(.uint(uIntValue)):
                return Float(uIntValue)
            case let .number(.float(floatValue)):
                return floatValue
            case let .number(.double(doubleValue)):
                return Float(doubleValue)
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .number(.float(newValue))
            } else {
                self = .null
            }
        }
    }
    
    public var doubleValue: Double? {
        get {
            switch self {
            case let .number(.int(intValue)):
                return Double(intValue)
            case let .number(.uint(uIntValue)):
                return Double(uIntValue)
            case let .number(.float(floatValue)):
                return Double(floatValue)
            case let .number(.double(doubleValue)):
                return doubleValue
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .number(.double(newValue))
            } else {
                self = .null
            }
        }
    }
    
    public var stringValue: String? {
        get {
            switch self {
            case let .string(stringValue):
                return stringValue
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .string(newValue)
            } else {
                self = .null
            }
        }
    }
    
    public var arrayValue: [JSON]? {
        get {
            switch self {
            case let .array(items):
                return items
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .array(newValue)
            } else {
                self = .null
            }
        }
    }
    
    public var objectValue: [String: JSON]? {
        get {
            switch self {
            case let .object(properties):
                return properties
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .object(newValue)
            } else {
                self = .null
            }
        }
    }
    
}
