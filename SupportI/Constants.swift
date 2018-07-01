//
//  Constants.swift
//  homeCheif
//
//  Created by mohamed abdo on 4/21/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//
import UIKit
import IQKeyboardManagerSwift
class Constants{
    //
    //  Costant.swift
    //  homeCheif
    //
    //  Created by mohamed abdo on 3/25/18.
    //  Copyright © 2018 Atiaf. All rights reserved.
    //
    
    static let locale = LocalizationHelper.getLocale()
    static let login = "Login"
    static let storyboard = Storyboards.main.rawValue
    static let currentApp:Apps = .client
    static let url = "http://fashion.atyf.co/api/"
    static let companyUrl = "http://fashion.atyf.co/"
    static let version = "v1"
    static let deviceType = "2"
    static let deviceToken = "deviceToken"

    static let mainColorRGB = UIColor(red: 122/255, green: 72/255, blue: 145/255, alpha: 1)
    static let textColorRGB = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    static let borderColorRGB = UIColor.init(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
    static let underlineRGB = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
    
    static var splash:Void!
    static func sleep(time:TimeInterval){
        Constants.splash = Thread.sleep(forTimeInterval: time)
        
    }
    static func initAppDelegate(){
        initLang()
        //Constants.sleep(time: 3)
        //Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
    }
    

}

public enum Storyboards:String{
    case main = "Main"
}

public enum Apps:Int{
    case designer = 3
    case client = 2
}

public enum PaymentsMethod:Int{
    case cash = 1
    case visa = 2
}

public enum Apis:String {
    case token
    case nearest_designers
    case home
    case login
    case register
    case send_contact_message
    case client_data = "client/data"
    case notifications
    case designer
    case order_drawing
    case rate
    case conversation
    case user_update = "user/update"
    case forgetPassword = "password/reset"
    case resetPassword = "password/verify"
    case settings
    case designs
    case addresses
    case conversations
    case message
    case order_status
    case getLocations
    case user_rate = "user/rates"
    case order_design
    case orders
    case drawing_design_data
    case paidOrder = "orders/pay"
    case logout
}


