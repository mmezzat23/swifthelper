import CoreData
import UIKit

public func api(_ method: EndPoint, _ paramters: [Any] = []) -> String {
    var url = method.rawValue
    for key in paramters {
        url += "/\(key)"
    }
    return url
}

extension BaseApi {
    func safeUrl(url: String) -> String {
        let safeURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return safeURL
    }
    func initGet(method: String) -> String {
        var genericUrl: String = method
        var counter = 0
        if self.paramaters.count > 0 {
            for (key, value) in self.paramaters {
                if counter == 0 {
                    genericUrl += "?"+key+"=\(value)"
                } else {
                    genericUrl += "&"+key+"=\(value)"
                }
                counter += 1
            }
        }
        return genericUrl
    }
    func setErrorMessage(data: Data?) {
        guard data != nil else { return }
        guard let error = try? JSONDecoder().decode(BaseModel.self, from: data ?? Data()) else { return }
        if let errors = error.errors {
            if error.message != nil {
                errors.message = error.message
            }
            self.makeAlert(errors.message ?? "", closure: {})
        }else if let errors = error.error {
            if error.message != nil {
                errors.message = error.message
            }
            self.makeAlert(errors.message ?? "", closure: {})
        } else {
            if error.message != nil {
                self.makeAlert(error.message!, closure: {})
            }
        }
    }
}
