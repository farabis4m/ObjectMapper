import XCTest
import ObjectMapper

class NSDecimalNumberTransformTests: XCTestCase {

    let mapper = Mapper<NSDecimalNumberType>()

    func testNSDecimalNumberTransform() {
        let int: Int = 11
        let double: Double = 11.11
        let intString = "\(int)"
        let doubleString = "\(double)"
        let JSONString = "{\"double\" : \(double), \"int\" : \(int), \"intString\" : \"\(intString)\", \"doubleString\" : \"\(doubleString)\"}"

        let mappedObject = mapper.map(JSONString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.int, NSDecimalNumber(value: int as Int))
        XCTAssertEqual(mappedObject?.double, NSDecimalNumber(value: double as Double))
        XCTAssertEqual(mappedObject?.intString, NSDecimalNumber(string: intString))
        XCTAssertEqual(mappedObject?.doubleString, NSDecimalNumber(string: doubleString))
    }
}

class NSDecimalNumberType: Mappable {

    var int: NSDecimalNumber?
    var double: NSDecimalNumber?
    var intString: NSDecimalNumber?
    var doubleString: NSDecimalNumber?

    required init(){

    }

    required init?(_ map: Map){

    }

    func mapping(_ map: Map) {
        int <- (map["int"], NSDecimalNumberTransform())
        double <- (map["double"], NSDecimalNumberTransform())
        intString <- (map["intString"], NSDecimalNumberTransform())
        doubleString <- (map["doubleString"], NSDecimalNumberTransform())
    }
}
