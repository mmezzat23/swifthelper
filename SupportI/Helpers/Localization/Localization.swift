//
//  Localization.swift
//  SupportI
//
//  Created by Mohamed Abdu on 2/13/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation

// MARK: - Constants
private let defaultLanguageSign = "default.language.ia"

final class Localizer: NSObject {
    
    private static let defaultSign = Bundle.main.preferredLocalizations[0]
    
    /**
     Get available languages from main bundle
     - returns: array of languages signs
     */
    public static func getSelectedLanguages() -> Array<String> {
        var languages = Bundle.main.localizations
        if let baseIndex = languages.index(of: "Base") {
            languages.remove(at: baseIndex)
        }
        return languages
    }
    
    /**
     Get default language or saved language
     - returns: language sign string
     */
    static var current: String {
        return UserDefaults.standard.string(forKey: defaultLanguageSign) ?? defaultSign
    }
    
    /**
     Save language and put it default
     - parameter language: may be language sign to save it
     - returns: void
     */
    static func set(language: String) {
        DispatchQueue.main.async {
            let lang = getSelectedLanguages().contains(language) ? language : defaultSign
            guard lang != current else { return }
            UserDefaults.standard.set(lang, forKey: defaultLanguageSign)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .languageDidChanged, object: lang)
        }
    }
    
}

// MARK: - Notifications.Name
extension Notification.Name {
    static var languageDidChanged: Notification.Name {
        return Notification.Name("language.did.changed.ia")
    }
}

// MARK: - Strings
extension String {
    
    /// get localize string for key from localizable files
    var localized: String {
        guard let languageStringsFilePath = Bundle.main.path(forResource: Localizer.current, ofType: "lproj") else {
            return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        }
        return Bundle(path: languageStringsFilePath)?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}
