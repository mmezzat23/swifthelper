//
//  Constants.swift
//  homeCheif
//
//  Created by mohamed abdo on 4/21/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//
import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces

struct Constants {
    
    static let locale = LocalizationHelper.getLocale()
    static var login:String {
        get{
            Constants.storyboard = Storyboards.main.rawValue
            return "LoginNav"
        }
    }
    static var storyboard = Storyboards.main.rawValue
    //static var currentApp:Apps = .client
    static let url = ""
    static let companyUrl = ""
    static let copyrightUrl = ""
    static let itunesURL = "itms-apps://itunes.apple.com/app/id1330387425"
    static let version = "v1"
    static let deviceType = "2"
    static let deviceToken = "deviceToken"
    static let deviceId = UIDevice.current.identifierForVendor!.uuidString
    static let googleAPI = "AIzaSyCGKTEvpfIbHSLZBvckDG06-KKQOGD6wyo"
    static let googleRoutesAPI = "AIzaSyDP115w2CRwFjSQDiCzYRJ4jFTu1IHS2qI"
    static var useAuth:Bool = false
    static var placeHolderImage: UIImage = UIImage(named: "placeHolder") ?? UIImage()
    
    static let mainColorRGB = UIColor(red: 140/255, green: 198/255, blue: 62/255, alpha: 1)
    static let textColorRGB = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    static let borderColorRGB = UIColor.init(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
    static let underlineRGB = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
    
    static var splash: Void!
    static func sleep(time:TimeInterval) {
        Constants.splash = Thread.sleep(forTimeInterval: time)
    }
    static func initAppDelegate(){
        initLang()
        //Constants.sleep(time: 3)
        //Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        
        GMSServices.provideAPIKey(Constants.googleAPI)
        GMSPlacesClient.provideAPIKey(Constants.googleAPI)
        
    }
    
    
}

public enum Fonts:String {
    case reg = ""
    //case reg = "DINNextLTW23-Regular"
    //case mid = "DINNextLTW23-Medium"
}
public enum Storyboards:String{
    case main = "Main"
}

public enum Apis:String {
    case token
    case update = "user/update"
    case login
    case register
    case logout
    case packages
    case packages_register = "packages/register"
    case get_user
    case locations
    case categories
    case ads
    case like
    case favorite
    case follow
    case comment
    case comments
    case report = "ads/report"
    case favorites
    case advertisers
    case auth_user
    case user_ads = "user/ads"
    case add_to_auction
    case settings
    case notifications
    case send_contact_message
    case banks
    case search = "ads/search"
}


