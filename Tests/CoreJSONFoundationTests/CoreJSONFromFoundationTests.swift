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

class CoreJSONFromFoundationTests: XCTestCase {
    
    private func data(from jsonValue: String) throws -> Any {
        let data = "{\"value\":\(jsonValue)}".data(using: .utf8)!
        
        let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        return jsonObj["value"]!
    }
    
    func testJSONIntNegativeExponential() throws {
        let jsonValue = "1E-3"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.number(.double(1E-3)))
    }
    
    func testJSONIntExponential() throws {
        let jsonValue = "1E3"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.number(.double(1E3)))
    }
    
    func testJSONBoolTrue() throws {
        let jsonValue = "true"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.bool(true))
    }
    
    func testJSONBoolFalse() throws {
        let jsonValue = "false"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.bool(false))
    }
    
    func testBoolTrue() throws {
        let json = try JSON(foundation: true)
        XCTAssertEqual(json, JSON.bool(true))
    }
    
    func testBoolFalse() throws {
        let json = try JSON(foundation: false)
        XCTAssertEqual(json, JSON.bool(false))
    }
    
    func testJSONInt() throws {
        let jsonValue = "1"
        let json = try JSON(foundation: try data(from: jsonValue))
        let expectation: Set<JSON> = [
            JSON.number(.int(1)),
            JSON.number(.int64(1)),
            JSON.number(.uint(1)),
            JSON.number(.uint64(1))]
        XCTAssertTrue(expectation.contains(json))
    }
    
    func testInt() throws {
        let json = try JSON(foundation: 1 as Int)
        XCTAssertEqual(json, JSON.number(.int(1)))
    }
    
    func testUInt() throws {
        let json = try JSON(foundation: 1 as UInt)
        XCTAssertEqual(json, JSON.number(.uint(1)))
    }
    
    func testInt64() throws {
        let json = try JSON(foundation: 1 as Int64)
        XCTAssertEqual(json, JSON.number(.int64(1)))
    }
    
    func testUInt64() throws {
        let json = try JSON(foundation: 1 as UInt64)
        XCTAssertEqual(json, JSON.number(.uint64(1)))
    }
    
    func testJSONDouble() throws {
        let jsonValue = "1.2"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.number(.double(1.2)))
    }
    
    func testFloat() throws {
        let json = try JSON(foundation: 1 as Float)
        XCTAssertEqual(json, JSON.number(.float(1)))
    }
    
    func testDouble() throws {
        let json = try JSON(foundation: 1 as Double)
        XCTAssertEqual(json, JSON.number(.double(1)))
    }
    
    func testFloatNumber() throws {
        let json = try JSON(foundation: NSNumber(value: 1 as Float))
        XCTAssertEqual(json, JSON.number(.float(1)))
    }
    
    func testInt64Number() throws {
        let json = try JSON(foundation: NSNumber(value: -2 as Int64))
        XCTAssertEqual(json, JSON.number(.int64(-2)))
    }
    
    func testUInt64Number() throws {
        let json = try JSON(foundation: NSNumber(value: UInt64.max))
        XCTAssertEqual(json, JSON.number(.uint64(UInt64.max)))
    }
    
    func testJSONString() throws {
        let jsonValue = "\"Simple string\""
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.string("Simple string"))
    }
    
    func testJSONNull() throws {
        let jsonValue = "null"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.null)
    }
    
    func testNil() throws {
        let json = try JSON(foundation: Optional<Any>.none as Any)
        XCTAssertEqual(json, JSON.null)
    }
    
    func testNonNilOptional() throws {
        let json = try JSON(foundation: Optional<Any>.some("string") as Any)
        XCTAssertEqual(json, JSON.string("string"))
    }
    
    func testJSONEmptyObject() throws {
        let jsonValue = "{}"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.object([:]))
    }
    
    func testJSONEmptyArray() throws {
        let jsonValue = "[]"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.array([]))
    }
    
    func testJSONNullArray() throws {
        let jsonValue = "[null, null]"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.array([.null, .null]))
    }
    
    func testJSONObject() throws {
        let jsonValue = "{\"Test\": \"123\"}"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.object(["Test": .string("123")]))
    }
    
    func testJSONIntArray() throws {
        let jsonValue = "[1,2,3]"
        let json = try JSON(foundation: try data(from: jsonValue))
        let expectation: Set<JSON> = [
            JSON.array([
                .number(.int(1)),
                .number(.int(2)),
                .number(.int(3))
            ]),
            JSON.array([
                .number(.int64(1)),
                .number(.int64(2)),
                .number(.int64(3))
            ]),
            JSON.array([
                .number(.uint(1)),
                .number(.uint(2)),
                .number(.uint(3))
            ]),
            JSON.array([
                .number(.uint64(1)),
                .number(.uint64(2)),
                .number(.uint64(3))
            ])
            
        ]
        XCTAssertTrue(expectation.contains(json))
    }
    
    func testJSONOptionalStringArray() throws {
        let jsonValue = "[\"Test\", \"123\", null]"
        let json = try JSON(foundation: try data(from: jsonValue))
        XCTAssertEqual(json, JSON.array([.string("Test"), .string("123"), .null]))
    }
    
    func testUnsupported() throws {
        do {
            let _ = try JSON(foundation: NSObject())
            XCTFail("Error should be thrown")
        } catch {
        }
    }
}
