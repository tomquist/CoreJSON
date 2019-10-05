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
import CoreJSONFoundation

class CoreJSONToFoundationTests: XCTestCase {
    
    func testString() {
        let json = JSON.string("string")
        XCTAssertEqual(json.toFoundation() as? String, "string")
    }
    
    func testNull() {
        let json = JSON.null
        XCTAssertEqual(json.toFoundation() as? NSNull, NSNull())
    }
    
    func testBoolTrue() {
        let json = JSON.bool(true)
        XCTAssertEqual(json.toFoundation() as? Bool, true)
    }
    
    func testBoolFalse() {
        let json = JSON.bool(false)
        XCTAssertEqual(json.toFoundation() as? Bool, false)
    }
    
    func testInt() {
        let json = JSON.number(.int(10))
        XCTAssertEqual(json.toFoundation() as? Int, 10)
    }
    
    func testUInt() {
        let json = JSON.number(.uint(10))
        XCTAssertEqual(json.toFoundation() as? UInt, 10)
    }
    
    func testDouble() {
        let json = JSON.number(.double(10))
        XCTAssertEqual(json.toFoundation() as? Double, 10)
    }
    
    func testEmptyArray() {
        let json = JSON.array([])
        XCTAssertEqual((json.toFoundation() as? [Any])?.count, 0)
    }
    
    func testArrayWithString() {
        let json = JSON.array([.string("string")])
        XCTAssertEqual((json.toFoundation() as? [Any])?.count, 1)
        XCTAssertEqual((json.toFoundation() as? [Any])?.first as? String, "string")
    }
    
    func testEmptyObject() {
        let json = JSON.object([:])
        XCTAssertEqual((json.toFoundation() as? [String: Any])?.count, 0)
    }
    
    func testObjectWithString() {
        let json = JSON.object(["key": .string("string")])
        XCTAssertEqual((json.toFoundation() as? [String: Any])?.count, 1)
        XCTAssertEqual((json.toFoundation() as? [String: Any])?["key"] as? String, "string")
    }
    
}
