import CoreData

class Errors: Decodable {

    var email: String?
    var fname: String?
    var id: Int?
    var image: String?
    var lname: String?
    var mobile: String?
    var building: String?
    var cityTitle: String?
    var countryTitle: String?
    var deliveryFees: Int?
    var floorNumber: String?
    var longAddress: String?
    var street: String?
    var category: String?
    var tallness: String?
    var shape: String?
    var password: String?
    var message: String?

//    func description() -> String {
//
//        let mirroredObject = Mirror(reflecting: self)
//        let str: NSMutableString = NSMutableString()
//        for (_, attr) in mirroredObject.children.enumerated() {
//
//            if let propertyName = attr.label as String? {
//                let string: String? = attr.value as? String
//                if let _ = string {
//                    str.append("\(propertyName) : \(string!)")
//                }
//
//            }
//        }
//        //print("desc=\(str)")
//        return str as String
//    }

    public static func convertToModel(response: Data?) -> Errors {
        do {
            let data = try JSONDecoder().decode(self, from: response!)
            return data
        } catch {
            return Errors()
        }
    }

}
