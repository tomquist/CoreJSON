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

public enum JSON {
    case null
    case bool(Bool)
    case number(JSONNumber)
    case string(String)
    case array([JSON])
    case object([String: JSON])
}

public enum JSONNumber {
    case int(Int)
    case int64(Int64)
    case uint(UInt)
    case uint64(UInt64)
    case float(Float)
    case double(Double)
}

extension JSON: Equatable {
    public static func ==(lhs: JSON, rhs: JSON) -> Bool {
        switch (lhs, rhs) {
        case (.null, .null): return true
        case let (.bool(bool1), .bool(bool2)): return bool1 == bool2
        case let (.number(number1), .number(number2)): return number1 == number2
        case let (.string(string1), .string(string2)): return string1 == string2
        case let (.array(array1), .array(array2)): return array1 == array2
        case let (.object(object1), .object(object2)): return object1 == object2
        default: return false
        }
    }
}

extension JSONNumber: Equatable {
    public static func ==(lhs: JSONNumber, rhs: JSONNumber) -> Bool {
        switch (lhs, rhs) {
        case let (.int(int1), .int(int2)): return int1 == int2
        case let (.int64(int1), .int64(int2)): return int1 == int2
        case let (.uint(uint1), .uint(uint2)): return uint1 == uint2
        case let (.uint64(uint1), .uint64(uint2)): return uint1 == uint2
        case let (.float(float1), .float(float2)): return float1 == float2
        case let (.double(double1), .double(double2)): return double1 == double2
        default: return false
        }
    }
}

extension JSON: Hashable {
    public var hashValue: Int {
        switch self {
        case .null: return 0
        case let .bool(bool): return bool.hashValue
        case let .number(number): return number.hashValue
        case let .string(string): return string.hashValue
        case let .array(array): return array.lazy.map { $0.hashValue }.reduce(0) { $1 + ($0 << 6) + ($0 << 16) &- $0 }
        case let .object(dict): return dict.lazy.map { $0.hashValue &+ $1.hashValue }.reduce(0) { $1 + ($0 << 6) + ($0 << 16) &- $0 }
        }
    }
}

extension JSONNumber: Hashable {
    public var hashValue: Int {
        switch self {
        case let .int(n): return n.hashValue
        case let .int64(n): return n.hashValue
        case let .uint(n): return n.hashValue
        case let .uint64(n): return n.hashValue
        case let .float(n): return n.hashValue
        case let .double(n): return n.hashValue
        }
    }
}
