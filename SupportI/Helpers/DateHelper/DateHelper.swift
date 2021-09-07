//
//  DateHelper.swift
//  SupportI
//
//  Created by Mohamed Abdu on 2/5/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation

class DateHelper {
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
    enum DateType: String {
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
    enum DateLocale: String {
        case english = "en_US_POSIX"
        case arabic = "ar_EG"
    }
    func currentFullFormat() -> String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.string(from: date)
        return dateOrginial
    }
    func currentDateFullFormat() -> Date? {
        guard let date = Date.current() else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.date(from: date)
        return dateOrginial
    }
    func currentDate() -> String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateOrginial = dateFormatter.string(from: date)
        return dateOrginial
    }
    /// start with date yyyy-mm-dd hh:mm:ii
    ///
    /// - Parameter original: string date
    /// - Returns: return Date Object
    func originalDate(original: String, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let dateOrginial = dateFormatter.date(from: original)
        return dateOrginial
    }
    func locale() -> String {
        var locale = ""
        if getAppLang() == "ar" {
            locale = DateLocale.arabic.rawValue
        } else {
            locale = DateLocale.english.rawValue
        }
        return locale
    }
    func date(date: String?, format: String, oldFormat: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        guard let dateUse = date else {return nil}
        let dateD = originalDate(original: dateUse, oldFormat: oldFormat)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: locale()) // set locale to reliable US_POSIX
        if dateD != nil {
            let dateString = dateFormatter.string(from: dateD!)
            return dateString
        } else {
            return nil
        }
    }
    func date(date: Date?, format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 2)
        dateFormatter.locale = Locale(identifier: locale()) // set locale to reliable US_POSIX
        if date != nil {
            let dateString = dateFormatter.string(from: date!)
            return dateString
        } else {
            return nil
        }
    }
    func convertToHoursMinutesSeconds (seconds: Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
    }
    func convertToHoursMinutesSeconds (firstTimeStamp: Int, secondTimeStamp: Int) -> (Int, Int) {
        let seconds = firstTimeStamp - secondTimeStamp
        return (seconds / 3600, (seconds % 3600) / 60)
    }
}
