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
import Foundation

/// Implements JSONPointer RFC6901
/// https://tools.ietf.org/rfc/rfc6901.txt
public struct JSONPointer {
    
    fileprivate struct PathItem {
        var value: String
        
        var arrayIndex: Int? {
            let chars = value.characters
            guard let firstChar = chars.first else {
                return nil
            }
            
            // Leading zero is not allowed
            guard firstChar != "-" && (firstChar != "0" || chars.dropFirst().isEmpty) else {
                return nil
            }
            return Int(value)
        }
        
        var isArrayEndIndex: Bool {
            return value == "-"
        }
        
    }
    
    fileprivate var path: [PathItem]
    
    public init?(string: String) {
        if string.isEmpty {
            path = [PathItem(value: "")]
        } else if string.hasPrefix("/") {
            path = string.components(separatedBy: "/").lazy.map {
                $0.replacingOccurrences(of: "~1", with: "/").replacingOccurrences(of: "~0", with: "~")
            }.map(PathItem.init)
        } else {
            return nil
        }
    }
    
}

extension JSONPointer.PathItem: Equatable {
    fileprivate static func == (lhs: JSONPointer.PathItem, rhs: JSONPointer.PathItem) -> Bool {
        return lhs.value == rhs.value
    }
}

extension JSONPointer: Equatable {
    
    public static func == (lhs: JSONPointer, rhs: JSONPointer) -> Bool {
        return lhs.path == rhs.path
    }
    
}

extension JSONPointer: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let pointer = JSONPointer(string: value) else {
            preconditionFailure("Invalid JSONPointer")
        }
        self = pointer
    }
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension JSONPointer {
    
    public var lastPathComponent: String? {
        return path.last?.value
    }
    
    public var pathComponents: [String] {
        return path.map { $0.value }
    }
    
}

private extension Dictionary {
    
    subscript(key: Key, or value: @autoclosure () -> Value?) -> Value? {
        get {
            return self[key] ?? value()
        }
        set {
            self[key] = newValue
        }
    }
    
}

private extension ArraySlice {
    
    func decompose() -> (Element, ArraySlice<Element>)? {
        guard let first = first else { return nil }
        return (first, dropFirst())
    }
}

extension JSON {
    
    private func get(path: ArraySlice<JSONPointer.PathItem>) -> JSON? {
        guard let (pathComponent, remaining) = path.decompose() else {
            return self
        }
        switch self {
        case let .array(items):
            guard let index = pathComponent.arrayIndex else {
                return nil
            }
            guard items.indices.contains(index) else {
                return nil
            }
            return items[index].get(path: remaining)
        case let .object(properties):
            return properties[pathComponent.value]?.get(path: remaining)
        default:
            return nil
        }
    }
    
    @discardableResult
    private mutating func set(path: ArraySlice<JSONPointer.PathItem>, value: JSON?) -> Bool {
        guard let (pathComponent, remaining) = path.decompose() else {
            self = value ?? .null
            return true
        }
        switch self {
        case var .array(items):
            if pathComponent.isArrayEndIndex {
                var addedItem: JSON = .null
                if value != nil && addedItem.set(path: remaining, value: value) {
                    items.append(addedItem)
                    self = .array(items)
                    return true
                }
                return false
            }
            guard let index = pathComponent.arrayIndex else {
                return false
            }
            while value != nil && !items.indices.contains(index) {
                items.append(.null)
            }
            items[index].set(path: remaining, value: value)
            self = .array(items)
            return true
        case var .object(properties):
            guard value != nil || !remaining.isEmpty else {
                properties[pathComponent.value] = nil
                self = .object(properties)
                return true
            }
            properties[pathComponent.value, or: value.map { _ in .null } ]?.set(path: path.dropFirst(), value: value)
            self = .object(properties)
            return true
        default:
            guard let value = value else {
                return true
            }
            var replacement: JSON
            if pathComponent.isArrayEndIndex || pathComponent.arrayIndex != nil {
                replacement = .array([])
            } else {
                replacement = .object([:])
            }
            replacement.set(path: path, value: value)
            self = replacement
            return true
        }
    }
    
    public subscript(pointer: JSONPointer) -> JSON? {
        get {
            return get(path: pointer.path.dropFirst())
        }
        set {
            set(path: pointer.path.dropFirst(), value: newValue)
        }
    }
    
}
