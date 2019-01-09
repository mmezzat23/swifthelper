//
//  DateHelper.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 5/30/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation

extension Date{
    /** Wednesday, May 30, 2018
     EEEE, MMM d, yyyy
     05/30/2018
     MM/dd/yyyy
     05-30-2018 12:14
     MM-dd-yyyy HH:mm
     May 30, 12:14 PM
     MMM d, h:mm a
     May 2018
     MMMM yyyy
     May 30, 2018
     MMM d, yyyy
     Wed, 30 May 2018 12:14:27 +0000
     E, d MMM yyyy HH:mm:ss Z
     2018-05-30T12:14:27+0000
     yyyy-MM-dd'T'HH:mm:ssZ
     30.05.18
     dd.MM.yy
     **/
    enum DateType:String {
        case hourly = "hh"
        case hourly24 = "HH"
        case hourlyM = "hh:mm"
        case hourly24M = "HH:mm"
        case year = "yyyy"
        case full = "yyyy-MM-dd HH:mm:ss"
        case monthString = "MMM"
        case month = "MM"
        case day = "dd"
        
    }
    enum DateLocale:String{
        case en = "en_US_POSIX"
        case ar = "ar_EG"
    }
    
    static func current()->String?{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.string(from:date)
        return dateOrginial
    }
    static func currentDate()->Date?{
        guard let date = Date.current() else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.date(from:date)
        return dateOrginial
    }
    static func currentDay()->String?{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.string(from:date)
        return dateOrginial
    }
    /// start with date yyyy-mm-dd hh:mm:ii
    ///
    /// - Parameter original: string date
    /// - Returns: return Date Object
    static func originalDate(original:String)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let dateOrginial = dateFormatter.date(from:original)
        return dateOrginial
    }
   
    static func locale()->String{
        var locale = ""
        if getAppLang() == "ar"{
            locale = DateLocale.en.rawValue
        }else{
            locale = DateLocale.en.rawValue
        }
        return locale
    }
    
    /// staticaly
    ///
    /// - Parameters:
    ///   - date: string date
    ///   - type: type convert date
    ///   - usePM: bool
    /// - Returns: Date object
    static func dateD(date:String? , type:DateType = .full , usePM:Bool = false)->Date?{
        guard let dateUse = date else {return nil}
        
        var typeEnum = type.rawValue
        if usePM{
            typeEnum = typeEnum+" a"
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = typeEnum
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: Date.locale()) // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:dateUse)
        return date
    }
    
    /// staticaly
    ///
    /// - Parameters:
    ///   - date: string date
    ///   - type: type convert date
    ///   - usePM: bool
    /// - Returns: date string
    static func date(date:String? , type:DateType = .full , usePM:Bool = false)->String?{
        guard let dateUse = date else {return nil}
        let dateD = originalDate(original: dateUse)

        // init type date
        var typeEnum = type.rawValue
        if usePM{
            typeEnum = typeEnum+" a"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = typeEnum
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: Date.locale()) // set locale to reliable US_POSIX
        
        if dateD != nil{
            let dateString = dateFormatter.string(from: dateD!)
            return dateString
        }else{
            return nil
        }
    }
    
    static func date(date:String? , format:[DateType] = [])->String?{
        guard let dateUse = date else {return nil}
        let dateD = originalDate(original: dateUse)
        
        var typeEnum = "yyyy"
        for dateT in format {
            if dateT == .month || dateT == .day{
                typeEnum = typeEnum+"-"+dateT.rawValue
            }else if dateT == .hourly || dateT == .hourlyM {
                typeEnum = typeEnum+" "+dateT.rawValue
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = typeEnum
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: Date.locale()) // set locale to reliable US_POSIX
        
        if dateD != nil{
            let dateString = dateFormatter.string(from: dateD!)
            return dateString
        }else{
            return nil
        }
    }
    static func date(date:String? , format:String)->String?{
        guard let dateUse = date else {return nil}
        let dateD = originalDate(original: dateUse)
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: Date.locale()) // set locale to reliable US_POSIX
        
        if dateD != nil{
            let dateString = dateFormatter.string(from: dateD!)
            return dateString
        }else{
            return nil
        }
    }
    
    static func convertToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    static func convertToHoursMinutesSeconds (firstTimeStamp:Int , secondTimeStamp:Int) -> (Int, Int, Int) {
        
        let seconds = firstTimeStamp - secondTimeStamp
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
}


