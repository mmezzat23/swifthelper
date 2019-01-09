//
//  SearchBarHelper.swift
//  homeCheif
//
//  Created by Mohamed Abdu on 4/19/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

fileprivate var searchImagePrivate:UIImage?
fileprivate var cancelImagePrivate:UIImage?
extension UISearchBar{
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
    
     func initSearchBar(){
        
        self.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setValue(translate("cancel"), forKey: "_cancelButtonText")
        
        var searchImageIcon = UIImage()
        var cancelImageIcon = UIImage()
        if LocalizationHelper.getAppLang() == "ar"{
            self.semanticContentAttribute = .forceRightToLeft
        }
        else{
            self.semanticContentAttribute = .forceLeftToRight
           
        }
        if searchImagePrivate != nil{
            searchImageIcon = searchImagePrivate!
            
            
        }
        if cancelImagePrivate != nil{
            cancelImageIcon = cancelImagePrivate!
        }
        self.setImage(searchImageIcon, for: .search, state: .normal)
        self.setImage(cancelImageIcon, for: .clear, state: .normal)
        

        for subView in self.subviews
        {
            for case let textField as UITextField in subView.subviews{
                textField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
                let attributeDict = [NSAttributedStringKey.foregroundColor: UIColor.white]
                textField.attributedPlaceholder = NSAttributedString(string: translate("search"), attributes: attributeDict)
                
                textField.textColor = .white
            }
            
            for innerSubViews in subView.subviews {
                if let cancelButton = innerSubViews as? UIButton {
                    cancelButton.setTitleColor(UIColor.white, for: .normal)
                    cancelButton.setTitle(translate("cancel"), for: .normal)
                }
            }
            
        }
        self.enablesReturnKeyAutomatically = false
        self.returnKeyType = .done
    }
    
    static func initSearchBar(searchBar:UISearchBar,delegate:UIViewController){
    
        searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setValue(translate("cancel"), forKey: "_cancelButtonText")
        
        var searchImage = UIImage()
        if LocalizationHelper.getAppLang() == "ar"{
            searchBar.semanticContentAttribute = .forceRightToLeft
        }
        else{
            searchBar.semanticContentAttribute = .forceLeftToRight
        }
        if searchImagePrivate != nil{
            searchImage = searchImagePrivate!
        }
        searchBar.setImage(searchImage, for: .search, state: .normal)
        searchBar.setImage(#imageLiteral(resourceName: "clearButton"), for: .clear, state: .normal)
        
        for subView in searchBar.subviews
        {
            for case let textField as UITextField in subView.subviews{
                textField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
                let attributeDict = [NSAttributedStringKey.foregroundColor: UIColor.white]
                textField.attributedPlaceholder = NSAttributedString(string: translate("search"), attributes: attributeDict)
                
                textField.textColor = .white
            }
            
            for innerSubViews in subView.subviews {
                if let cancelButton = innerSubViews as? UIButton {
                    cancelButton.setTitleColor(UIColor.white, for: .normal)
                    cancelButton.setTitle(translate("cancel"), for: .normal)
                }
            }
            
        }
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = .done
        searchBar.delegate = delegate as? UISearchBarDelegate
    }
}
