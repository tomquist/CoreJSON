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
    
    public subscript(key: String) -> JSON? {
        get {
            switch self {
            case let .object(properties):
                return properties[key]
            default:
                return nil
            }
        }
        set {
            switch self {
            case .null:
                guard let newValue = newValue else { break }
                var object = JSON.object([:])
                object[key] = newValue
                self = object
            case var .object(properties):
                properties[key] = newValue
                self = .object(properties)
            default:
                break
            }
        }
    }
    
    public subscript(index: Int) -> JSON? {
        get {
            switch self {
            case let .array(items):
                return items.indices.contains(index) ? items[index] : .none
            default:
                return nil
            }
        }
        set {
            switch self {
            case .null:
                guard let newValue = newValue else { break }
                var array = JSON.array([])
                array[index] = newValue
                self = array
            case var .array(items):
                if let newValue = newValue {
                    while !items.indices.contains(index) {
                        items.append(.null)
                    }
                    items[index] = newValue
                } else if items.indices.contains(index) {
                    items.remove(at: index)
                }
                self = .array(items)
            default:
                break
            }
        }
    }
    
}
