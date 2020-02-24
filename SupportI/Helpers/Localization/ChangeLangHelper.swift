//
//  ChangeLangHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/6/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//

import Foundation
import UIKit


func changeLang(closure:@escaping ()->()) {
    let alert = UIAlertController(title: "change_language.lan".localized, message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "العربية", style: .default, handler: { _ in
        setAppLang("ar")
        initLang()
        closure()
        
    }))
    
    alert.addAction(UIAlertAction(title: "الأنجليزية", style: .default, handler: { _ in
        setAppLang("en")
        initLang()
        closure()
        
        
    }))
    
    alert.addAction(UIAlertAction.init(title: "cancel".localized, style: .cancel, handler: nil))
    
    /*If you want work actionsheet on ipad
     then you have to use popoverPresentationController to present the actionsheet,
     otherwise app will crash on iPad */
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        alert.popoverPresentationController?.permittedArrowDirections = .up
        alert.popoverPresentationController?.sourceView = UIApplication.topViewController()?.view

    default:
        break
    }
    
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
}

