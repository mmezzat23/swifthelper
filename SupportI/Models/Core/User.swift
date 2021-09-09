//
//    RootClass.swift
//
//    Create by imac on 29/4/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import UIKit

class UserRoot: Codable {
    public static var storeUserDefaults: String = "userDataDefaults"
    public static var storeRememberUser: String = "USER_LOGIN_REMEMBER"

    var data: User?
    var expires_in: Int?
    var access_token: String?
    var token: String?
    var refresh_token: String?
    var message: String?
    var loginTimeStamp: Int?

    public static func convertToModel(response: Data?) -> UserRoot {
        do {
            let data = try JSONDecoder().decode(self, from: response ?? Data())
            return data
        } catch {
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
    public func save() {
        guard let response = try? JSONEncoder().encode(self) else { return }
        UserDefaults.standard.set(response, forKey: UserRoot.storeUserDefaults)
    }
    public static func fetch() -> UserRoot? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        return user
    }
    public static func token() -> String? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        return user.token
    }
    public static func loginAlert(closure: HandlerView? = nil) {
        let handler: HandlerView? = {
            guard let vcr = Constants.loginNav else { return }
            UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
        }
        let alert = UIAlertController(title: "alert.lan".localized, message: "you_must_be_logged_in.lan".localized,
                                      preferredStyle: UIAlertController.Style.alert)
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

class User: Codable {

    var email: String?
    var dialCode: String?
    var name: String?
    var logo: String?
    var description: String?
    var mobile: String?
    var images: [String]?
    var companyOffers: [CompanyOffer]?
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case logo
        case description
        case mobile
        case images
        case companyOffers = "company_offers"
        case dialCode = "dial_code"
        //case type
    }
    class CompanyOffer: Codable {
        var id: Int?
        var title: String?
        var icon: String?
    }
}
