//
//  LocalizationHelper.swift
//  homeCheif
//
//  Created by Mohamed Abdu on 4/17/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

class LocalizationHelper {
    
    public static var keys = keysTranslation
    public static func initLang(){
        if(self.getAppLang() == "ar" || self.getAppLang() == "AR"){
            
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }else{
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    public static func getAppLang()->String{
        if let lang = UserDefaults.standard.string(forKey: "lang"){
            return lang
        }else{
            return "ar"
        }
       
        
    }
    public static func getLocale()->String{
        if let locale = UserDefaults.standard.string(forKey: "locale"){
            return locale
        }else{
            return "ar_EG"
        }
    }
    public static func setAppLang(_ lang:String)->String{
        let defaults = UserDefaults.standard
        defaults.set(lang , forKey: "lang")
        
        if lang == "ar"{
            defaults.set("ar_EG", forKey: "locale")
        }else{
            defaults.set("en_US", forKey: "locale")
        }
        return lang
    }
    public static func key(_ key:String)->String{
        let lang = LocalizationHelper.getAppLang()
        if let translate =  LocalizationHelper.keys[key]{
            if(lang == "ar"){
                return translate
            }else{
                return key.cut()
            }
        }else{
            return key.cut()
        }
    }
    public static func key(item:String?,_ key:String)->String{
        var itemNew = ""
        if(item != nil){
            itemNew = item!
        }
        let lang = LocalizationHelper.getAppLang()
        if let translate =  LocalizationHelper.keys[key]{
            if(lang == "ar"){
                return itemNew+" "+translate
            }else{
                return itemNew+" "+key.cut()
            }
        }else{
            return itemNew+" "+key.cut()
        }
    }
    public static func key(item:String?,_ key:String,orderable:Bool)->String{
        var itemNew = ""
        if(item != nil){
            itemNew = item!
        }
        let lang = LocalizationHelper.getAppLang()
        if let translate =  LocalizationHelper.keys[key]{
            if(lang == "ar"){
                return translate+" "+itemNew
            }else{
                return key.cut()+" "+itemNew
            }
        }else{
            return itemNew+" "+key.cut()
        }
    }
}


