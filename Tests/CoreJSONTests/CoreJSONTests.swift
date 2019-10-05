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

class CoreJSONTests: XCTestCase {
    
    func testEqualsNull() {
        XCTAssertEqual(JSON.null, .null)
        XCTAssertNotEqual(JSON.null, .string(""))
        XCTAssertNotEqual(JSON.null, .number(.int(10)))
        XCTAssertNotEqual(JSON.null, .bool(false))
        XCTAssertNotEqual(JSON.null, .array([]))
        XCTAssertNotEqual(JSON.null, .object([:]))
    }
    
    func testEqualsBool() {
        XCTAssertEqual(JSON.bool(true), .bool(true))
        XCTAssertNotEqual(JSON.bool(true), .bool(false))
        XCTAssertNotEqual(JSON.bool(true), .string(""))
        XCTAssertNotEqual(JSON.bool(true), .number(.int(10)))
        XCTAssertNotEqual(JSON.bool(true), .null)
        XCTAssertNotEqual(JSON.bool(true), .array([]))
        XCTAssertNotEqual(JSON.bool(true), .object([:]))
    }
    
    func testEqualsString() {
        XCTAssertEqual(JSON.string("string"), .string("string"))
        XCTAssertNotEqual(JSON.string("string"), .string("other"))
        XCTAssertNotEqual(JSON.string("string"), .bool(true))
        XCTAssertNotEqual(JSON.string("string"), .number(.int(10)))
        XCTAssertNotEqual(JSON.string("string"), .null)
        XCTAssertNotEqual(JSON.string("string"), .array([]))
        XCTAssertNotEqual(JSON.string("string"), .object([:]))
    }
    
    func testEqualsArray() {
        XCTAssertEqual(JSON.array([]), .array([]))
        XCTAssertNotEqual(JSON.array([]), .array([.null]))
        XCTAssertNotEqual(JSON.array([]), .bool(true))
        XCTAssertNotEqual(JSON.array([]), .number(.int(10)))
        XCTAssertNotEqual(JSON.array([]), .null)
        XCTAssertNotEqual(JSON.array([]), .string(""))
        XCTAssertNotEqual(JSON.array([]), .object([:]))
    }
    
    func testEqualsObject() {
        XCTAssertEqual(JSON.object([:]), .object([:]))
        XCTAssertNotEqual(JSON.object([:]), .object(["key": .null]))
        XCTAssertNotEqual(JSON.object([:]), .bool(true))
        XCTAssertNotEqual(JSON.object([:]), .number(.int(10)))
        XCTAssertNotEqual(JSON.object([:]), .null)
        XCTAssertNotEqual(JSON.object([:]), .string(""))
        XCTAssertNotEqual(JSON.object([:]), .array([]))
    }
    
    func testEqualsNumber() {
        XCTAssertEqual(JSON.number(.int(10)), .number(.int(10)))
        XCTAssertNotEqual(JSON.number(.int(10)), .number(.int(11)))
        XCTAssertNotEqual(JSON.number(.int(10)), .object(["key": .null]))
        XCTAssertNotEqual(JSON.number(.int(10)), .bool(true))
        XCTAssertNotEqual(JSON.number(.int(10)), .object([:]))
        XCTAssertNotEqual(JSON.number(.int(10)), .null)
        XCTAssertNotEqual(JSON.number(.int(10)), .string(""))
        XCTAssertNotEqual(JSON.number(.int(10)), .array([]))
    }
    
    func testEqualsInt() {
        XCTAssertEqual(JSONNumber.int(10), .int(10))
        XCTAssertNotEqual(JSONNumber.int(10), .int(11))
        XCTAssertNotEqual(JSONNumber.int(10), .uint(10))
        XCTAssertNotEqual(JSONNumber.int(10), .double(10))
    }
    
    func testEqualsUInt() {
        XCTAssertEqual(JSONNumber.uint(10), .uint(10))
        XCTAssertNotEqual(JSONNumber.uint(10), .uint(11))
        XCTAssertNotEqual(JSONNumber.uint(10), .int(10))
        XCTAssertNotEqual(JSONNumber.uint(10), .double(10))
    }

    func testEqualsDouble() {
        XCTAssertEqual(JSONNumber.double(10), .double(10))
        XCTAssertNotEqual(JSONNumber.double(10), .double(11))
        XCTAssertNotEqual(JSONNumber.double(10), .int(10))
        XCTAssertNotEqual(JSONNumber.double(10), .uint(10))
    }
    
    func testHashNull() {
        XCTAssertEqual(JSON.null.hashValue, JSON.null.hashValue)
    }
    
    func testHashString() {
        XCTAssertEqual(JSON.string("string").hashValue, JSON.string("string").hashValue)
        XCTAssertNotEqual(JSON.string("string").hashValue, JSON.string("tring").hashValue)
    }
    
    func testHashBool() {
        XCTAssertEqual(JSON.bool(true).hashValue, JSON.bool(true).hashValue)
        XCTAssertNotEqual(JSON.bool(true).hashValue, JSON.bool(false).hashValue)
    }
    
    func testHashNumber() {
        XCTAssertEqual(JSON.number(.int(10)).hashValue, JSON.number(.int(10)).hashValue)
        XCTAssertNotEqual(JSON.number(.int(10)).hashValue, JSON.number(.int(11)).hashValue)
    }
    
    func testHashArray() {
        XCTAssertEqual(JSON.array([]).hashValue, JSON.array([]).hashValue)
        XCTAssertEqual(JSON.array([.bool(true)]).hashValue, JSON.array([.bool(true)]).hashValue)
        XCTAssertNotEqual(JSON.array([]).hashValue, JSON.array([.bool(true)]).hashValue)
    }
    
    func testHashObject() {
        XCTAssertEqual(JSON.object([:]).hashValue, JSON.object([:]).hashValue)
        XCTAssertEqual(JSON.object(["key":.string("value")]).hashValue, JSON.object(["key":.string("value")]).hashValue)
        XCTAssertNotEqual(JSON.object([:]).hashValue, JSON.object(["key":.string("value")]).hashValue)
    }
    
    func testHashInt() {
        XCTAssertEqual(JSONNumber.int(10).hashValue, JSONNumber.int(10).hashValue)
        XCTAssertNotEqual(JSONNumber.int(10).hashValue, JSONNumber.int(11).hashValue)
    }
    
    func testHashUInt() {
        XCTAssertEqual(JSONNumber.uint(10).hashValue, JSONNumber.uint(10).hashValue)
        XCTAssertNotEqual(JSONNumber.uint(10).hashValue, JSONNumber.uint(11).hashValue)
    }
    
    func testHashDouble() {
        XCTAssertEqual(JSONNumber.double(10).hashValue, JSONNumber.double(10).hashValue)
        XCTAssertNotEqual(JSONNumber.double(10).hashValue, JSONNumber.double(11).hashValue)
    }

}
