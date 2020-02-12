import CoreData
import UIKit


public func api(_ method:Apis , _ paramters:[Any] = [])->String {
    var url = method.rawValue
    for key in paramters{
        url = url+"/\(key)"
    }
    return url
    
}

extension BaseApi {
   
    func safeUrl(url:String) -> String {
        let safeURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return safeURL
    }
    func initGet(method:String)-> String{
        
        var genericUrl:String = method
        var counter = 0
        
        if(self.paramaters.count > 0){
            for (key , value) in self.paramaters{
                
                
                if(counter == 0){
                    genericUrl = genericUrl+"?"+key+"=\(value)"
                }else{
                    genericUrl = genericUrl+"&"+key+"=\(value)"
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
            if let _ = error.message {
                errors.message = error.message
            }
            self.makeAlert(errors.description(), closure: {})
        } else {
            if let _ = error.message {
                self.makeAlert(error.message!, closure: {})
            }
        }
        
    }
    
}
