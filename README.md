# CoreJson

CoreJSON provides a simple JSON data model and on top of that a collection of utilities.

## Modules
CoreJSON consists of several modules:
* Core: Provides a simple JSON data model which conforms to Equatable and Hashable
* Convenience: Provides some convenient value accessors to extract JSON content without checking the JSON node type
* Subscript: Allows subscripting JSON values by key (for objects) or index (for arrays)
* Literals: Allows converting an Integer, Nil, String, Float, Boolean, Array and Dictionary literal into JSON
* Foundation: Converts the result of (NS)JSONSerialization into CoreJSONs JSON model and vice-versa
* Pointer: Implementation of JSON pointer ([rfc6901](https://tools.ietf.org/rfc/rfc6901.txt))


## Examples

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
