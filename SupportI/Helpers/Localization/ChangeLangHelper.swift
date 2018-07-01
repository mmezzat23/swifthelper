//
//  ChangeLangHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/6/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//

import Foundation
import UIKit


func changeLang(closure:@escaping ()->()){
    let alert = UIAlertController(title: translate("change_language"), message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "العربية", style: .default, handler: { _ in
        _ = setAppLang("ar")
        initLang()
        closure()
        
    }))
    
    alert.addAction(UIAlertAction(title: "الأنجليزية", style: .default, handler: { _ in
        _ = setAppLang("en")
        initLang()
        closure()
        
        
    }))
    
    alert.addAction(UIAlertAction.init(title: translate("cancel"), style: .cancel, handler: nil))
    
    /*If you want work actionsheet on ipad
     then you have to use popoverPresentationController to present the actionsheet,
     otherwise app will crash on iPad */
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        alert.popoverPresentationController?.permittedArrowDirections = .up
    default:
        break
    }
    
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
}


func changeLang(refresh:String = "Home",menu:Bool = true){
     let storyboard: UIStoryboard = UIStoryboard(name: Constants.storyboard, bundle: nil)
    let topView =  UIApplication.topMostController()
    
    let alert = UIAlertController(title: translate("change_language"), message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "العربية", style: .default, handler: { _ in
        _ = setAppLang("ar")
        initLang()
       
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: refresh)
        if menu{
            let swMenu = topView as? SWRevealViewController
            
            if swMenu != nil{
                MenuVC.resetMenu()
                swMenu?.pushFrontViewController(vc, animated: true)
            }else{
                topView.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            topView.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }))
    
    alert.addAction(UIAlertAction(title: "الأنجليزية", style: .default, handler: { _ in
        _ = setAppLang("en")
        initLang()
        
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: refresh)
        if menu{
            let swMenu = topView as? SWRevealViewController
            
            if swMenu != nil{
                MenuVC.resetMenu()
                swMenu?.pushFrontViewController(vc, animated: true)
            }else{
                topView.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            topView.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }))
    
    alert.addAction(UIAlertAction.init(title: translate("cancel"), style: .cancel, handler: nil))
    
    /*If you want work actionsheet on ipad
     then you have to use popoverPresentationController to present the actionsheet,
     otherwise app will crash on iPad */
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        alert.popoverPresentationController?.permittedArrowDirections = .up
    default:
        break
    }
    
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
}
