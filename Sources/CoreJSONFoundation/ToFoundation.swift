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

extension JSON {
    
    public func toFoundation() -> Any {
        switch self {
        case .null: return NSNull()
        case let .string(string): return string
        case let .number(jsonNumber): return jsonNumber.toFoundation()
        case let .bool(bool): return bool
        case let .object(props): return props.mapValues { $0.toFoundation() }
        case let .array(values): return values.map { $0.toFoundation() }
        }
    }
    
}

extension JSONNumber {
    
    public func toFoundation() -> Any {
        switch self {
        case let .double(double): return double
        case let .int(int): return int
        case let .uint(uint): return uint
        }
    }
}


private extension Dictionary {
    
    func mapValues<T>(_ transform: (Value) -> T) -> Dictionary<Key, T> {
        var result = [Key: T]()
        forEach { key, value in
            result[key] = transform(value)
        }
        return result
    }
    
}
