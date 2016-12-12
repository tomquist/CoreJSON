/*:
 # CoreJSON
 */
import CoreJSON

// CoreJSON provides a very simple JSON data model
let simpleJSON = JSON.array([
        JSON.bool(true),
        JSON.string("string"),
        JSON.null,
        JSON.number(.int(10)),
        JSON.object([:])
    ])

// JSON is equatable and hashable
simpleJSON == simpleJSON
JSON.bool(true) == .null
simpleJSON.hashValue


/*:
 ## CoreJSONLiterals
 */
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

/*:
 ## CoreJSONSubscript
 */
import CoreJSONSubscript
var firstBook = json["books"]?[0]
let bookName = firstBook?["name"]
var jsonCopy = json
jsonCopy["books"]?[1] = .string("changed")
jsonCopy["books"]?[1]

/*:
 ## CoreJSONConvenience
 */
import CoreJSONConvenience
bookName?.stringValue
firstBook?["pages"]?.intValue
firstBook?["pages"]?.intValue = 100
firstBook?["pages"]?.intValue

/*:
 ## CoreJSONPointer
 (RFC6901)
 */
import CoreJSONPointer
json["/books/1/author/lastName" as JSONPointer]?.stringValue

/*:
 ## CoreJSONFoundation
 */
import CoreJSONFoundation
import Foundation
let jsonData = try! JSONSerialization.data(withJSONObject: json.toFoundation(), options: .prettyPrinted)
String(data: jsonData, encoding: .utf8)
let parsedJSON = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
try! JSON(foundation: parsedJSON)
