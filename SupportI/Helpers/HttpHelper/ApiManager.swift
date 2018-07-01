//
//  ApiController.swift
//
//
//  Created by Algazzar on 4/1/18.
//
import CoreData
import Alamofire


class ApiManager:BaseApi,Api {
 
    struct Static {
        static var instance: ApiManager?
    }
    
    class var instance : ApiManager {
        
        if(Static.instance == nil) {
            Static.instance = ApiManager()
        }
        
        return Static.instance!
    }
  
   
    override func connection(_ method: String, type: HTTPMethod, completionHandler: @escaping (Data?) -> ()) {
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method,type: type, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:Constants.login)
            }
        }
    }
    func connection(_ method: Apis, type: HTTPMethod, completionHandler: @escaping (Data?) -> ()) {
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method.rawValue,type: type, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:Constants.login)
            }
        }
    }
   
}

extension ApiManager{
    func callGet(_ method:Apis ,_ completionHandler: @escaping (Data?) -> ()) {
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method.rawValue,type: .get, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:"LoginVC")
            }
        }

    }
    func callGet(_ method:String ,_ completionHandler: @escaping (Data?) -> ()) {
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method,type: .get, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:"LoginVC")
            }
        }
        
        
    }
}
extension ApiManager{
    func callPost(_ method:Apis ,_ completionHandler: @escaping (Data?) -> ()) {
        
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method.rawValue,type: .post, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:"LoginVC")
            }
        }
        
        
    }
    func callPost(_ method:String ,_ completionHandler: @escaping (Data?) -> ()) {
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
               super.connection(method,type: .post, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:"LoginVC")
            }
        }
        
    }
}

extension ApiManager{
    func callPut(_ method:Apis ,_ completionHandler: @escaping (Data?) -> ()) {
        
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method.rawValue,type: .put, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:"LoginVC")
            }
        }
        
        
    }
    func callPut(_ method:String ,_ completionHandler: @escaping (Data?) -> ()) {
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method,type: .put, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:"LoginVC")
            }
        }
        
    }
}

extension ApiManager{
    func callDelete(_ method:Apis ,_ completionHandler: @escaping (Data?) -> ()) {
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method.rawValue,type: .delete, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:"LoginVC")
            }
        }

    }
    func callDelete(_ method:String ,_ completionHandler: @escaping (Data?) -> ()) {
        Authorization.instance.refreshToken(){ callback in
            if callback{
                super.refresh()
                super.connection(method,type: .delete, completionHandler: completionHandler)
            }else{
                self.showAlert(message: translate("aunthorized"),indetifier:"LoginVC")
            }
        }
       
    }
}
