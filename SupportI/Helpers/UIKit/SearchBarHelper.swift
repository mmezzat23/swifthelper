//
//  SearchBarHelper.swift
//  homeCheif
//
//  Created by Mohamed Abdu on 4/19/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

private var searchImagePrivate: UIImage?
private var cancelImagePrivate: UIImage?
extension UISearchBar {
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var searchImage: UIImage {
        get {
            return self.searchImage
        }
        set {
            searchImagePrivate = newValue
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var cancelImage: UIImage {
        get {
            return self.cancelImage
        }
        set {
            cancelImagePrivate = newValue
        }
    }

     func initSearchBar() {

        self.tintColor = .white

        self.translatesAutoresizingMaskIntoConstraints = false
        self.setValue("cancel.lan".localized, forKey: "_cancelButtonText")

        var searchImageIcon = UIImage()
        var cancelImageIcon = UIImage()
        if Localizer.current == "ar" {
            self.semanticContentAttribute = .forceRightToLeft
        } else {
            self.semanticContentAttribute = .forceLeftToRight

        }
        if searchImagePrivate != nil {
            searchImageIcon = searchImagePrivate!

        }
        if cancelImagePrivate != nil {
            cancelImageIcon = cancelImagePrivate!
        }
        self.setImage(searchImageIcon, for: .search, state: .normal)
        self.setImage(cancelImageIcon, for: .clear, state: .normal)

        for subView in self.subviews {
            for case let textField as UITextField in subView.subviews {
                textField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
                let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.white]
                textField.attributedPlaceholder = NSAttributedString(string: "search.lan".localized, attributes: attributeDict)

                textField.textColor = .white
            }

            for innerSubViews in subView.subviews {
                if let cancelButton = innerSubViews as? UIButton {
                    cancelButton.setTitleColor(UIColor.white, for: .normal)
                    cancelButton.setTitle("cancel.lan".localized, for: .normal)
                }
            }

        }
        self.enablesReturnKeyAutomatically = false
        self.returnKeyType = .done
    }

}
