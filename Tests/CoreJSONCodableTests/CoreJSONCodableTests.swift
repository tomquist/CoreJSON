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

import XCTest
import CoreJSON
import CoreJSONCodable

final class CoreJSONCodableTests: XCTestCase {

    func testEncodingAndDecoding() throws {
        let json = JSON.object([
            "string": .string("test"),
            "true": .bool(true),
            "false": .bool(false),
            "null": .null,
            "array": .array([
                .null,
                .string("string"),
                .bool(true)
            ]),
            "numbers": .object([
                "int": .number(.int(-2)),
                "uint": .number(.uint(.max)),
                "double": .number(.double(.greatestFiniteMagnitude)),
            ])
        ])
        let encoder = JSONEncoder()
        if #available(OSX 10.13, *) {
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        }
        let data = try encoder.encode(json)
        let decoded = try JSONDecoder().decode(JSON.self, from: data)
        XCTAssertEqual(json, decoded)
    }

}
