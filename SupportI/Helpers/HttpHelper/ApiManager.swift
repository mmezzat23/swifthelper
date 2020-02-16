//
//  ApiController.swift
//
//
//  Created by Algazzar on 4/1/18.
//
import CoreData
import Alamofire


class ApiManager: BaseApi, Api {
 
    struct Static {
        static var instance: ApiManager?
    }
    
    class var instance : ApiManager {
        
        if(Static.instance == nil) {
            Static.instance = ApiManager()
        }
        
        return Static.instance!
    }
  
    static var useAuth:Bool = Constants.useAuth
   
    override func connection(_ method: String, type: HTTPMethod, completionHandler: @escaping (Data?) -> ()) {
        if ApiManager.useAuth {
            Authorization.instance.refreshToken(){ callback in
                if callback {
                    super.refresh()
                    super.connection(method,type: type, completionHandler: completionHandler)
                }else{
                    self.makeAlert(translate("aunthorized"), closure: {
                        print("Go TO Login")
                        guard let vc = Constants.loginNav else { return }
                        UIApplication.topMostController().navigationController?.pushViewController(vc, animated: true)
                    })
                }
            }
        }else{
            super.refresh()
            super.connection(method,type: type, completionHandler: completionHandler)
        }
       
    }
    func connection(_ method: Apis, type: HTTPMethod, completionHandler: @escaping (Data?) -> ()) {
        if ApiManager.useAuth {
            Authorization.instance.refreshToken(){ callback in
                if callback{
                    super.refresh()
                    super.connection(method.rawValue,type: type, completionHandler: completionHandler)
                }else{
                    self.makeAlert(translate("aunthorized"), closure: {
                        print("Go TO Login")
                        guard let vc = Constants.loginNav else { return }
                        UIApplication.topMostController().navigationController?.pushViewController(vc, animated: true)
                    })
                }
            }
        }else{
            super.refresh()
            super.connection(method.rawValue,type: type, completionHandler: completionHandler)
        }
        
    }
   
}
