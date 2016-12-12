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
import XCTest
import CoreJSON
import CoreJSONLiterals

class CoreJSONLiteralsTests: XCTestCase {
    
    func testStringLiteral() {
        XCTAssertEqual(JSON.string("test"), "test" as JSON)
        XCTAssertEqual(JSON.string(""), "" as JSON)
        XCTAssertEqual(JSON.string(""), JSON(unicodeScalarLiteral: ""))
        XCTAssertEqual(JSON.string(""), JSON(extendedGraphemeClusterLiteral: ""))
    }
    
    func testIntegerLiteral() {
        XCTAssertEqual(JSON.number(.int(10)), 10 as JSON)
        XCTAssertEqual(JSON.number(.int(-10)), -10 as JSON)
    }
    
    func testFloatLiteral() {
        XCTAssertEqual(JSON.number(.double(10)), 10.0 as JSON)
        XCTAssertEqual(JSON.number(.double(-10)), -10.0 as JSON)
    }
    
    func testBooleanLiteral() {
        XCTAssertEqual(JSON.bool(true), true as JSON)
        XCTAssertEqual(JSON.bool(false), false as JSON)
    }
    
    func testNilLiteral() {
        XCTAssertEqual(JSON.null, nil as JSON)
    }
    
    func testArrayLiteral() {
        XCTAssertEqual(JSON.array([]), [] as JSON)
        XCTAssertEqual(JSON.array([.string("123")]), [JSON.string("123")] as JSON)
    }
    
    func testDictionaryLiteral() {
        XCTAssertEqual(JSON.object([:]), [:] as JSON)
        XCTAssertEqual(JSON.object(["key": .string("123")]), ["key": JSON.string("123")] as JSON)
    }
    
}

#if os(Linux)
extension CoreJSONLiteralsTests {
    static var allTests : [(String, (CoreJSONLiteralsTests) -> () throws -> Void)] {
        return [
            ("testArrayLiteral", testArrayLiteral),
            ("testBooleanLiteral", testBooleanLiteral),
            ("testDictionaryLiteral", testDictionaryLiteral),
            ("testFloatLiteral", testFloatLiteral),
            ("testIntegerLiteral", testIntegerLiteral),
            ("testNilLiteral", testNilLiteral),
            ("testStringLiteral", testStringLiteral),
        ]
    }
}
#endif
