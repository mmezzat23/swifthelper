//
//    RootClass.swift
//
//    Create by imac on 29/4/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import UIKit


class UserRoot : Decodable {
    public static var storeUserDefaults: String = "userDataDefaults"
    public static var storeRememberUser: String = "USER_LOGIN_REMEMBER"
    
    var result : User?
    var errors : Errors?
    var expires_in : Int?
    var access_token : String?
    var refresh_token : String?
    var message : String?
    var loginTimeStamp: Int?
    
    public static func convertToModel(response: Data?) -> UserRoot{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
        }catch{
            return UserRoot()
        }
    }

    
    public static func save(response: Data?, remember: Bool = true) {
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp).int
        UserDefaults.standard.set(response, forKey: storeUserDefaults)
        UserDefaults.standard.set(myTimeInterval, forKey: "LOGIN_TIMESTAMP")
        if remember {
            UserDefaults.standard.set(true, forKey: storeRememberUser)
        }
    }
    public static func fetch() -> UserRoot? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        return user
    }
    public static func token() -> String? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        return user.access_token
    }
    public static func LoginAlert(closure: HandlerView? = nil) {
        let handler: HandlerView? = {
            guard let vc = Constants.loginNav else { return }
            UIApplication.topMostController().navigationController?.pushViewController(vc, animated: true)
        }
        let alert = UIAlertController(title: "alert.lan".localized, message: "you_must_be_logged_in.lan".localized, preferredStyle: UIAlertController.Style.alert)
        let acceptAction = UIAlertAction(title: "sure.lan".localized, style: .default) { (_) -> Void in
            handler?()
        }
        let cancelAction = UIAlertAction(title: "cancel.lan".localized, style: .default) { (_) -> Void in
        }
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}



class User: Decodable {
    
    var email : String?
    var fname : String?
    var id : Int?
    var image : String?
    var lname : String?
    var mobile : Int?
    var password : String?
    
}
