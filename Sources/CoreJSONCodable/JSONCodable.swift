/**
*  CoreJSON
*
*  Copyright (c) 2019 Tom Quist. Licensed under the MIT license, as follows:
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

import CoreJSON

extension JSON: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null: try container.encodeNil()
        case let .bool(bool): try container.encode(bool)
        case let .string(string): try container.encode(string)
        case let .number(number): try container.encode(number)
        case let .array(array): try container.encode(array)
        case let .object(object): try container.encode(object)
        }
    }
}

extension JSONNumber: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .int(number): try container.encode(number)
        case let .uint(number): try container.encode(number)
        case let .double(number): try container.encode(number)
        }
    }
}

extension JSON: Decodable {

    public init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(), let json = JSON(from: container) {
            self = json
        } else if let array = try? [JSON](from: decoder) {
            self = .array(array)
        } else if let object = try? [String: JSON](from: decoder) {
            self = .object(object)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context.init(codingPath: decoder.codingPath, debugDescription: "Could not decoding into any known JSON value"))
        }
    }

    private init?(from container: SingleValueDecodingContainer) {
        if container.decodeNil() {
            self = .null
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let number = try? container.decode(Int.self) {
            self = .number(.int(number))
        } else if let number = try? container.decode(UInt.self) {
            self = .number(.uint(number))
        } else if let number = try? container.decode(Double.self) {
            self = .number(.double(number))
        } else {
            return nil
        }
    }

}
