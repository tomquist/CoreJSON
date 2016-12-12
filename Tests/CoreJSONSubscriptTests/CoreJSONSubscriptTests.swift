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
import CoreJSONConvenience
import CoreJSONLiterals
import CoreJSONSubscript

class CoreJSONSubscriptTests: XCTestCase {
    
    
    func testStringSubscript() {
        XCTAssertNil(JSON.null["test"])
        XCTAssertNil(JSON.string("text")["test"])
        XCTAssertNil(JSON.bool(false)["test"])
        XCTAssertNil(JSON.number(.int(10))["test"])
        XCTAssertNil(JSON.array([])["test"])
        XCTAssertNil(JSON.object([:])["test"])
        XCTAssertEqual(JSON.object(["test":"value"])["test"], JSON.string("value"))
        
        var val = JSON.object([:])
        val["123"] = "test"
        XCTAssertEqual(val.objectValue!, ["123":"test"])
        val["123"] = nil
        XCTAssertEqual(val.objectValue!, [:])
        val = .null
        val["123"] = .none
        XCTAssertTrue(val.isNull)
        val["123"] = "test"
        XCTAssertEqual(val.objectValue!, ["123":"test"])
        
        val = "test"
        val["123"] = 10
        XCTAssertEqual(val, "test")
    }
    
    func testIntSubscript() {
        XCTAssertNil(JSON.null[0])
        XCTAssertNil(JSON.string("text")[0])
        XCTAssertNil(JSON.bool(false)[0])
        XCTAssertNil(JSON.number(.int(10))[0])
        XCTAssertNil(JSON.array([])[0])
        XCTAssertNil(JSON.object([:])[0])
        XCTAssertEqual(JSON.array(["test", "value"])[1], JSON.string("value"))
        
        var val = JSON.array([])
        val[0] = "test"
        XCTAssertEqual(val.arrayValue!, ["test"])
        val[0] = nil
        XCTAssertEqual(val.arrayValue!, [])
        val = .null
        val[0] = .none
        XCTAssertTrue(val.isNull)
        val[0] = "test"
        XCTAssertEqual(val.arrayValue!, ["test"])
        
        val = "test"
        val[0] = 10
        XCTAssertEqual(val, "test")
    }
    
}

#if os(Linux)
extension CoreJSONSubscriptTests {
    static var allTests : [(String, (CoreJSONSubscriptTests) -> () throws -> Void)] {
        return [
            ("testIntSubscript", testIntSubscript),
            ("testStringSubscript", testStringSubscript),
        ]
    }
}
#endif
