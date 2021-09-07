//
//  Localization.swift
//  SupportI
//
//  Created by Mohamed Abdu on 2/13/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Constants
private let defaultLanguageSign = "default.language.ia"
public func initLang() {
    Localizer.initLang()
}
public func getAppLang() -> String {
    return Localizer.current
}
public func setAppLang(_ lang: Languages) {
    Localizer.set(language: lang)
}
final class Localizer: NSObject {
    public static func initLang() {
        if current == "ar" || current == "AR" {
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UIStackView.appearance().semanticContentAttribute = .forceRightToLeft
            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
            UISearchBar.appearance().semanticContentAttribute = .forceRightToLeft

        } else {
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UIStackView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
            UISearchBar.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }

    public static func getLocale() -> String {
        if let locale = UserDefaults.standard.string(forKey: "locale") {
            return locale
        } else {
            return "ar_EG"
        }
    }

    public static let defaultSign = Bundle.main.preferredLocalizations[0]
    /**
     Get available languages from main bundle
     - returns: array of languages signs
     */
    public static func getSelectedLanguages() -> [String] {
        var languages = Bundle.main.localizations
        if let baseIndex = languages.firstIndex(of: "Base") {
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
    static func set(language: Languages) {
        DispatchQueue.main.async {
            let lang = getSelectedLanguages().contains(language.rawValue) ? language.rawValue : defaultSign
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
        let char = "\""
        print("\(char)\(self)\(char) = \(char) \(char);")
        guard let languageStringsFilePath = Bundle.main.path(forResource: Localizer.current, ofType: "lproj") else {
            return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        }
        return Bundle(path: languageStringsFilePath)?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}
