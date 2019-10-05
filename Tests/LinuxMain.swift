import XCTest

import CoreJSONCodableTests
import CoreJSONConvenienceTests
import CoreJSONFoundationTests
import CoreJSONLiteralsTests
import CoreJSONPointerTests
import CoreJSONSubscriptTests
import CoreJSONTests

var tests = [XCTestCaseEntry]()
tests += CoreJSONCodableTests.__allTests()
tests += CoreJSONConvenienceTests.__allTests()
tests += CoreJSONFoundationTests.__allTests()
tests += CoreJSONLiteralsTests.__allTests()
tests += CoreJSONPointerTests.__allTests()
tests += CoreJSONSubscriptTests.__allTests()
tests += CoreJSONTests.__allTests()

XCTMain(tests)
