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
    public static var issaller: String = "saller"
    public static var mode: String = "mode"

    var responseData: Token?
    var data: User?
    var expires_in: Int?
    var access_token: String?
    var token: String?
    var isSuccess: Bool?
    var errorMessage: String?
    var statusCode: Int?
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
    public static func savemode( remember: String = "light") {
        UserDefaults.standard.set(remember, forKey: mode)
    }
    public static func savesaller( remember: Bool = false) {
        UserDefaults.standard.set(remember, forKey: issaller)
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
        return user.responseData?.access_Token
    }
    public static func isrember() -> Bool? {
        let data = UserDefaults.standard.bool(forKey: storeRememberUser)
        return data
    }
    public static func saller() -> Bool? {
        let data = UserDefaults.standard.bool(forKey: issaller)
        return data
    }
    public static func modetype() -> String? {
        let data = UserDefaults.standard.string(forKey: mode)
        if (data == nil){
            return "light"
        }else{
        return data
        }
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

class Token: Codable {
    var access_Token: String?
    var refresh_Token: String?
    var expires_In: Int?
    var userId: String?
    var userName: String?
    var isVerified: Bool?
    var name: String?
    var bio: String?
    var cover: String?
    var profile: String?
    var picWithId: String?
    var dateOfBirth: String?
    var gender: Int?
    var text: String?
    var twitter: String?
    var facebook: String?
    var website: String?
    var email: String?
    var password: String?
    var phone: String?
    var isNotificationOn: Bool?
    var status: Int?
    var language: Int?
    var isDarkMode: Bool?
    var paymentType: Int?
    var city: ItemCity?
    var isActiveSeller: Bool?
    var hasProduct: Bool?
    var shopStatus: Bool?
    var isValid: Bool?
    var number: String?
    var productId: String?
    var screen: Int?
}
