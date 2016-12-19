[![Build Status](https://travis-ci.org/tomquist/CoreJSON.svg?branch=master)](https://travis-ci.org/tomquist/CoreJSON)
[![codecov.io](https://codecov.io/github/tomquist/CoreJSON/coverage.svg)](https://codecov.io/github/tomquist/CoreJSON)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/CoreJSON.svg?style=flat)](https://cocoapods.org/pods/CoreJSON)
[![Swift Package Manager Compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/tomquist/CoreJSON)
[![Platform support](https://img.shields.io/badge/platform-ios%20%7C%20osx%20%7C%20tvos%20%7C%20watchos%20%7C%20linux-brightgreen.svg?style=flat)](https://github.com/tomquist/CoreJSON)
[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/tomquist/CoreJSON/blob/master/LICENSE)

# CoreJSON

CoreJSON provides a simple JSON data model and on top of that a collection of utilities.

## Modules
CoreJSON consists of several modules:
* _Core_: Provides a simple JSON data model which conforms to Equatable and Hashable
* _Convenience_: Provides some convenient value accessors to extract JSON content without checking the JSON node type
* _Subscript_: Allows subscripting JSON values by key (for objects) or index (for arrays)
* _Literals_: Allows converting an Integer, Nil, String, Float, Boolean, Array and Dictionary literal into JSON
* _Foundation_: Converts the result of (NS)JSONSerialization into CoreJSONs JSON model and vice-versa
* _Pointer_: Implementation of JSON pointer ([rfc6901](https://tools.ietf.org/rfc/rfc6901.txt))


## Demo

### Core
```swift
import CoreJSON

// CoreJson provides a very simple JSON data model
let simpleJson = JSON.array([
        JSON.bool(true),
        JSON.string("string"),
        JSON.null,
        JSON.number(.int(10)),
        JSON.object([:])
    ])

// JSON is equatable and hashable
simpleJson == simpleJson // -> true
JSON.bool(true) == .null // -> false
simpleJson.hashValue // -> Some hash value
```

### Literals
```swift
import CoreJSONLiterals

var json: JSON = [
    "books": [
        [
            "name": "Sample Book",
            "pages": 141,
            "author": [
                "firstName": "John",
                "lastName": "Doe",
                "age": 43
            ]
        ],
        [
            "name": "How to not create code examples",
            "pages": 53,
            "author": [
                "firstName": "Mike",
                "lastName": "Miller",
                "age": 27
            ]
        ]
    ]
]
```

### Subscript
```swift
import CoreJSONSubscript

var firstBook = json["books"]?[0] // -> JSON.object(...)
let bookName = firstBook?["name"] // -> JSON.string("Sample Book")
var jsonCopy = json
jsonCopy["books"]?[1] = .string("changed")
jsonCopy["books"]?[1] // -> JSON.string("changed")
```

### Convenience
```swift
import CoreJSONConvenience

bookName?.stringValue // -> "Sample Book"
firstBook?["pages"]?.intValue // -> 141
firstBook?["pages"]?.intValue = 100
firstBook?["pages"]?.intValue // -> 100
```

### Pointer
```swift
import CoreJSONPointer

json["/books/1/author/lastName" as JSONPointer]?.stringValue
json["/books/-" as JSONPointer] = [
            "name": "JSON for dummies",
            "pages": 612,
            "author": [
                "firstName": "Richard",
                "lastName": "Roe",
                "age": 34
            ]
        ]
```

### Foundation
```swift
import CoreJSONFoundation
import Foundation
let jsonData = try! JSONSerialization.data(withJSONObject: json.toFoundation(), options: .prettyPrinted)
String(data: jsonData, encoding: .utf8) // -> JSON string
let parsedJson = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
try! JSON(foundation: parsedJson)
```
