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
import CoreJSONPointer

class CoreJSONPointerTests: XCTestCase {
    
    func testRfcExamples() {
        let json: JSON = [
            "foo": ["bar", "baz"],
            "": 0,
            "a/b": 1,
            "c%d": 2,
            "e^f": 3,
            "g|h": 4,
            "i\\j": 5,
            "k\"l": 6,
            " ": 7,
            "m~n": 8
        ]
        XCTAssertEqual(json["" as JSONPointer], json)
        XCTAssertEqual(json["/foo" as JSONPointer], ["bar", "baz"])
        XCTAssertEqual(json["/foo/0" as JSONPointer], "bar")
        XCTAssertEqual(json["/" as JSONPointer], 0)
        XCTAssertEqual(json["/a~1b" as JSONPointer], 1)
        XCTAssertEqual(json["/c%d" as JSONPointer], 2)
        XCTAssertEqual(json["/e^f" as JSONPointer], 3)
        XCTAssertEqual(json["/g|h" as JSONPointer], 4)
        XCTAssertEqual(json["/i\\j" as JSONPointer], 5)
        XCTAssertEqual(json["/k\"l" as JSONPointer], 6)
        XCTAssertEqual(json["/ " as JSONPointer], 7)
        XCTAssertEqual(json["/m~0n" as JSONPointer], 8)
    }
    
    func testEscapeOrder() {
        let json: JSON = ["~1": "value1", "/0": "value2", "~/": "value3"]
        XCTAssertEqual(json["/~01" as JSONPointer], "value1")
        XCTAssertEqual(json["/~10" as JSONPointer], "value2")
        XCTAssertEqual(json["/~0~1" as JSONPointer], "value3")
    }
    
    func testEmptyPointer() {
        var json: JSON = [:]
        XCTAssertEqual(json["" as JSONPointer], json)
        json = ""
        XCTAssertEqual(json["" as JSONPointer], json)
        json = 10
        XCTAssertEqual(json["" as JSONPointer], json)
        json = true
        XCTAssertEqual(json["" as JSONPointer], json)
        json = [""]
        XCTAssertEqual(json["" as JSONPointer], json)
        json = ["key": "value"]
        XCTAssertEqual(json["" as JSONPointer], json)
        
        json["" as JSONPointer] = 10
        XCTAssertEqual(json, 10)
        
        json["" as JSONPointer] = Optional.none
        XCTAssertEqual(json, .null)
    }
    
    func testEmptyKey() {
        var json: JSON = ["":"value"]
        XCTAssertEqual(json["/" as JSONPointer], "value")
        
        json["/" as JSONPointer] = 10
        XCTAssertEqual(json["/" as JSONPointer], 10)
    }
    
    func testEmptyArrayIndex() {
        var json: JSON = [""]
        XCTAssertEqual(json["/" as JSONPointer], nil)
        
        json["/" as JSONPointer] = 10
        XCTAssertEqual(json, [""])
    }
    
    func testNonEmptyKey() {
        var json: JSON = ["key":"value"]
        XCTAssertEqual(json["/key" as JSONPointer], "value")
        
        json["/key" as JSONPointer] = 10
        XCTAssertEqual(json["/key" as JSONPointer], 10)
        
        json["/key" as JSONPointer] = Optional.none
        XCTAssertEqual(json["/key" as JSONPointer], Optional.none)
        
        json["/key" as JSONPointer] = 10
        XCTAssertEqual(json["/key" as JSONPointer], 10)
    }
    
    func testEmptyKeyOnString() {
        let json: JSON = "test"
        XCTAssertEqual(json["/" as JSONPointer], nil)
    }
    
    func testKeyOnArray() {
        let json: JSON = [1, 2, 3]
        XCTAssertEqual(json["/test" as JSONPointer], nil)
        
        var jsonCopy = json
        jsonCopy["/test" as JSONPointer] = Optional.none
        XCTAssertEqual(jsonCopy, json)
    }
    
    func testNonExistingArrayIndex() {
        let json: JSON = [1, 2, 3]
        XCTAssertEqual(json["/10" as JSONPointer], nil)
    }
    
    func testArrayIndex() {
        var json: JSON = [1, 2, 3]
        XCTAssertEqual(json["/1" as JSONPointer], 2)
        
        json["/1" as JSONPointer] = 4
        XCTAssertEqual(json["/1" as JSONPointer], 4)
    }
    
    func testLeadingZeroArrayIndex() {
        var json: JSON = [1, 2, 3]
        XCTAssertEqual(json["/01" as JSONPointer], nil)
        
        json["/01" as JSONPointer] = 4
        XCTAssertEqual(json, [1, 2, 3])
    }
    
    func testArrayAppend() {
        var json: JSON = [1, 2, 3]
        json["/-" as JSONPointer] = 4
        XCTAssertEqual(json["/3" as JSONPointer], 4)
        
        var jsonCopy = json
        jsonCopy["/-" as JSONPointer] = Optional.none
        XCTAssertEqual(jsonCopy, json)
    }
    
    func testSetIndexOutOfBounds() {
        var json: JSON = [1, 2, 3]
        json["/3" as JSONPointer] = 4
        XCTAssertEqual([1, 2, 3, 4], json)
    }
    
    func testCreationOfObject() {
        var json: JSON = [:]
        json["/test1/test2" as JSONPointer] = "value"
        XCTAssertEqual(["test1": ["test2": "value"]], json)
    }
    
    func testCreationOfArray() {
        var json: JSON = [:]
        json["/test1/0" as JSONPointer] = "value"
        XCTAssertEqual(["test1": ["value"]], json)
    }
    
    func testCreationOfArrayWithEndIndex() {
        var json: JSON = [:]
        json["/test1/-" as JSONPointer] = "value"
        XCTAssertEqual(["test1": ["value"]], json)
    }
    
    func testResetNonExistingPath() {
        var json: JSON = [:]
        json["/test1/test2" as JSONPointer] = Optional.none
        XCTAssertEqual([:], json)
    }
    
    func testMutateNested() {
        var json: JSON = ["test1": ["test2": "value"]]
        json["/test1/test2" as JSONPointer] = "other"
        XCTAssertEqual(["test1": ["test2": "other"]], json)
    }
    
    func testResetNested() {
        var json: JSON = ["test1": ["test2": "value"]]
        json["/test1/test2" as JSONPointer] = Optional.none
        XCTAssertEqual(["test1": [:]], json)
    }
    
    func testResetOnString() {
        var json: JSON = "test"
        json["/test1/test2" as JSONPointer] = Optional.none
        XCTAssertEqual(json, "test")
    }
    
    func testLiteral() {
        XCTAssertEqual(JSONPointer(string: ""), "" as JSONPointer)
        XCTAssertEqual(JSONPointer(string: "/"), "/" as JSONPointer)
        XCTAssertEqual(JSONPointer(string: "/test"), "/test" as JSONPointer)
        XCTAssertEqual(JSONPointer(string: "/test/10"), "/test/10" as JSONPointer)
        XCTAssertNotEqual(JSONPointer(string: "/test"), "/test/10" as JSONPointer)

        XCTAssertEqual(JSONPointer(string: "/test/10"), JSONPointer(unicodeScalarLiteral: "/test/10"))
        XCTAssertEqual(JSONPointer(string: "/test/10"), JSONPointer(extendedGraphemeClusterLiteral: "/test/10"))
    }
    
    func testLastPathComponent() {
        XCTAssertEqual(JSONPointer(string: "")?.lastPathComponent, "")
        XCTAssertEqual(JSONPointer(string: "/")?.lastPathComponent, "")
        XCTAssertEqual(JSONPointer(string: "/test")?.lastPathComponent, "test")
        XCTAssertEqual(JSONPointer(string: "/test/10")?.lastPathComponent, "10")
        XCTAssertEqual(JSONPointer(string: "/test/~0")?.lastPathComponent, "~")
        XCTAssertEqual(JSONPointer(string: "/test/~1")?.lastPathComponent, "/")
    }
    
    func testPathComponents() {
        XCTAssertEqual(JSONPointer(string: "")!.pathComponents, [""])
        XCTAssertEqual(JSONPointer(string: "/")!.pathComponents, ["", ""])
        XCTAssertEqual(JSONPointer(string: "/test")!.pathComponents, ["", "test"])
        XCTAssertEqual(JSONPointer(string: "/test/10")!.pathComponents, ["", "test", "10"])
        XCTAssertEqual(JSONPointer(string: "/test/~0")!.pathComponents, ["", "test", "~"])
        XCTAssertEqual(JSONPointer(string: "/test/~1")!.pathComponents, ["", "test", "/"])
    }
    
}
