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

class CoreJSONConvenienceTests: XCTestCase {
    
    func testIsNull() {
        XCTAssertTrue(JSON.null.isNull)
        XCTAssertFalse(JSON.string("").isNull)
        XCTAssertFalse(JSON.bool(false).isNull)
        XCTAssertFalse(JSON.number(.int(10)).isNull)
        XCTAssertFalse(JSON.array([]).isNull)
        XCTAssertFalse(JSON.object([:]).isNull)
    }
    
    func testIsString() {
        XCTAssertFalse(JSON.null.isString)
        XCTAssertTrue(JSON.string("").isString)
        XCTAssertFalse(JSON.bool(false).isString)
        XCTAssertFalse(JSON.number(.int(10)).isString)
        XCTAssertFalse(JSON.array([]).isString)
        XCTAssertFalse(JSON.object([:]).isString)
    }
    
    func testIsBool() {
        XCTAssertFalse(JSON.null.isBool)
        XCTAssertFalse(JSON.string("").isBool)
        XCTAssertTrue(JSON.bool(false).isBool)
        XCTAssertFalse(JSON.number(.int(10)).isBool)
        XCTAssertFalse(JSON.array([]).isBool)
        XCTAssertFalse(JSON.object([:]).isBool)
    }
    
    func testIsNumber() {
        XCTAssertFalse(JSON.null.isNumber)
        XCTAssertFalse(JSON.string("").isNumber)
        XCTAssertFalse(JSON.bool(false).isNumber)
        XCTAssertTrue(JSON.number(.int(10)).isNumber)
        XCTAssertFalse(JSON.array([]).isNumber)
        XCTAssertFalse(JSON.object([:]).isNumber)
    }
    
    func testIsInt() {
        XCTAssertFalse(JSON.null.isInt)
        XCTAssertFalse(JSON.string("").isInt)
        XCTAssertFalse(JSON.bool(false).isInt)
        XCTAssertTrue(JSON.number(.int(10)).isInt)
        XCTAssertFalse(JSON.number(.uint(10)).isInt)
        XCTAssertFalse(JSON.number(.double(10)).isInt)
        XCTAssertFalse(JSON.array([]).isInt)
        XCTAssertFalse(JSON.object([:]).isInt)
    }
    
    func testIsUInt() {
        XCTAssertFalse(JSON.null.isUInt)
        XCTAssertFalse(JSON.string("").isUInt)
        XCTAssertFalse(JSON.bool(false).isUInt)
        XCTAssertFalse(JSON.number(.int(10)).isUInt)
        XCTAssertTrue(JSON.number(.uint(10)).isUInt)
        XCTAssertFalse(JSON.number(.double(10)).isUInt)
        XCTAssertFalse(JSON.array([]).isUInt)
        XCTAssertFalse(JSON.object([:]).isUInt)
    }
    
    func testIsDouble() {
        XCTAssertFalse(JSON.null.isDouble)
        XCTAssertFalse(JSON.string("").isDouble)
        XCTAssertFalse(JSON.bool(false).isDouble)
        XCTAssertFalse(JSON.number(.int(10)).isDouble)
        XCTAssertFalse(JSON.number(.uint(10)).isDouble)
        XCTAssertTrue(JSON.number(.double(10)).isDouble)
        XCTAssertFalse(JSON.array([]).isDouble)
        XCTAssertFalse(JSON.object([:]).isDouble)
    }
    
    func testIsArray() {
        XCTAssertFalse(JSON.null.isArray)
        XCTAssertFalse(JSON.string("").isArray)
        XCTAssertFalse(JSON.bool(false).isArray)
        XCTAssertFalse(JSON.number(.int(10)).isArray)
        XCTAssertTrue(JSON.array([]).isArray)
        XCTAssertFalse(JSON.object([:]).isArray)
    }
    
    func testIsObject() {
        XCTAssertFalse(JSON.null.isObject)
        XCTAssertFalse(JSON.string("").isObject)
        XCTAssertFalse(JSON.bool(false).isObject)
        XCTAssertFalse(JSON.number(.int(10)).isObject)
        XCTAssertFalse(JSON.array([]).isObject)
        XCTAssertTrue(JSON.object([:]).isObject)
    }
    
    func testStringValue() {
        XCTAssertNil(JSON.null.stringValue)
        XCTAssertEqual(JSON.string("text").stringValue, "text")
        XCTAssertNil(JSON.bool(false).stringValue)
        XCTAssertNil(JSON.number(.int(10)).stringValue)
        XCTAssertNil(JSON.array([]).stringValue)
        XCTAssertNil(JSON.object([:]).stringValue)
        
        var val = JSON.null
        val.stringValue = "text"
        XCTAssertTrue(val.isString)
        XCTAssertEqual(val.stringValue, "text")
        val.stringValue = nil
        XCTAssertTrue(val.isNull)
    }
    
    func testBoolValue() {
        XCTAssertNil(JSON.null.boolValue)
        XCTAssertNil(JSON.string("").boolValue)
        XCTAssertFalse(JSON.bool(false).boolValue ?? true)
        XCTAssertTrue(JSON.bool(true).boolValue ?? false)
        XCTAssertNil(JSON.number(.int(10)).boolValue)
        XCTAssertNil(JSON.array([]).boolValue)
        XCTAssertNil(JSON.object([:]).boolValue)
        
        var val = JSON.null
        val.boolValue = true
        XCTAssertTrue(val.isBool)
        XCTAssertTrue(val.boolValue ?? false)
        val.boolValue = nil
        XCTAssertTrue(val.isNull)
    }
    
    func testIntValue() {
        XCTAssertNil(JSON.null.intValue)
        XCTAssertNil(JSON.string("text").intValue)
        XCTAssertNil(JSON.bool(false).intValue)
        XCTAssertEqual(JSON.number(.int(10)).intValue, 10)
        XCTAssertEqual(JSON.number(.uint(10)).intValue, 10)
        XCTAssertEqual(JSON.number(.double(10)).intValue, 10)
        XCTAssertNil(JSON.array([]).intValue)
        XCTAssertNil(JSON.object([:]).intValue)
        
        var val = JSON.null
        val.intValue = 10
        XCTAssertTrue(val.isInt)
        XCTAssertEqual(val.intValue, 10)
        val.intValue = nil
        XCTAssertTrue(val.isNull)
    }
    
    func testUIntValue() {
        XCTAssertNil(JSON.null.uintValue)
        XCTAssertNil(JSON.string("text").uintValue)
        XCTAssertNil(JSON.bool(false).uintValue)
        XCTAssertEqual(JSON.number(.int(10)).uintValue, 10)
        XCTAssertEqual(JSON.number(.uint(10)).uintValue, 10)
        XCTAssertEqual(JSON.number(.double(10)).uintValue, 10)
        XCTAssertNil(JSON.array([]).uintValue)
        XCTAssertNil(JSON.object([:]).uintValue)
        
        var val = JSON.null
        val.uintValue = 10
        XCTAssertTrue(val.isUInt)
        XCTAssertEqual(val.uintValue, 10)
        val.uintValue = nil
        XCTAssertTrue(val.isNull)
    }

    func testDoubleValue() {
        XCTAssertNil(JSON.null.doubleValue)
        XCTAssertNil(JSON.string("text").doubleValue)
        XCTAssertNil(JSON.bool(false).doubleValue)
        XCTAssertEqual(JSON.number(.int(10)).doubleValue, 10)
        XCTAssertEqual(JSON.number(.uint(10)).doubleValue, 10)
        XCTAssertEqual(JSON.number(.double(10)).doubleValue, 10)
        XCTAssertNil(JSON.array([]).doubleValue)
        XCTAssertNil(JSON.object([:]).doubleValue)
        
        var val = JSON.null
        val.doubleValue = 10
        XCTAssertTrue(val.isDouble)
        XCTAssertEqual(val.doubleValue, 10)
        val.doubleValue = nil
        XCTAssertTrue(val.isNull)
    }
    
    func testArrayValue() {
        XCTAssertNil(JSON.null.arrayValue)
        XCTAssertNil(JSON.string("text").arrayValue)
        XCTAssertNil(JSON.bool(false).arrayValue)
        XCTAssertNil(JSON.number(.int(10)).arrayValue)
        XCTAssertEqual(JSON.array([.number(.int(10)), .string("123")]).arrayValue!, [.number(.int(10)), .string("123")])
        XCTAssertNil(JSON.object([:]).arrayValue)
        
        var val = JSON.null
        val.arrayValue = [.number(.int(10)), .string("123")]
        XCTAssertTrue(val.isArray)
        XCTAssertEqual(val.arrayValue!, [.number(.int(10)), .string("123")])
        val.arrayValue = nil
        XCTAssertTrue(val.isNull)
    }
    
    func testObjectValue() {
        XCTAssertNil(JSON.null.objectValue)
        XCTAssertNil(JSON.string("text").objectValue)
        XCTAssertNil(JSON.bool(false).objectValue)
        XCTAssertNil(JSON.number(.int(10)).objectValue)
        XCTAssertNil(JSON.array([.number(.int(10)), .string("123")]).objectValue)
        XCTAssertEqual(JSON.object(["key": .string("value")]).objectValue!, ["key": .string("value")])
        
        var val = JSON.null
        val.objectValue = ["key": .string("value")]
        XCTAssertTrue(val.isObject)
        XCTAssertEqual(val.objectValue!, ["key": .string("value")])
        val.objectValue = nil
        XCTAssertTrue(val.isNull)
    }
    
}
