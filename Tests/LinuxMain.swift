import XCTest
@testable import CoreJSONTests
@testable import CoreJSONSubscriptTests
@testable import CoreJSONPointerTests
@testable import CoreJSONLiteralsTests
@testable import CoreJSONFoundationTests
@testable import CoreJSONConvenienceTests

XCTMain([
    testCase(CoreJSONTests.allTests),
    testCase(CoreJSONSubscriptTests.allTests),
    testCase(CoreJSONPointerTests.allTests),
    testCase(CoreJSONLiteralsTests.allTests),
    testCase(CoreJSONFromFoundationTests.allTests),
    testCase(CoreJSONToFoundationTests.allTests),
    testCase(CoreJSONConvenienceTests.allTests),
])
