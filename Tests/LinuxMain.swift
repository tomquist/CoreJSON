import XCTest
@testable import CoreJSONTests

XCTMain([
    testCase(CoreJSONTests.allTests),
    testCase(CoreJSONSubscriptTests.allTests),
    testCase(CoreJSONPointerTests.allTests),
    testCase(CoreJSONLiteralsTests.allTests),
    testCase(CoreJSONFromFoundationTests.allTests),
    testCase(CoreJSONToFoundationTests.allTests),
    testCase(CoreJSONConvenienceTests.allTests),
])
