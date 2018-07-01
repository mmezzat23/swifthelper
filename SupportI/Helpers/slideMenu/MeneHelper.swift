//
//  MeneHelper.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 4/25/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

class MenueHelper{
    struct Static {
        static var instance: MenueHelper?
    }
    
    class var instance : MenueHelper {
        
        if(Static.instance == nil) {
            Static.instance = MenueHelper()
        }
        
        return Static.instance!
    }
    
    func setUpMenuButton(delegate:UIViewController ,menuBtn: UIBarButtonItem ){
        let menu = delegate.storyboard!.instantiateViewController(withIdentifier: "MenuVC")
        //menuBtn.tag = delegate.revealViewController()
        if LocalizationHelper.getAppLang() == "ar"{
            delegate.revealViewController().rearViewController = nil
            delegate.revealViewController().rightViewRevealWidth = delegate.view.frame.width - 50
            delegate.revealViewController().rightViewController = menu
            menuBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            //menuBtn.action =
        }
        else{
            delegate.revealViewController().rearViewRevealWidth = delegate.view.frame.width - 50
            delegate.revealViewController().rearViewController = menu
            delegate.revealViewController().rightViewController = nil
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            //menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        delegate.view.addGestureRecognizer(delegate.revealViewController().tapGestureRecognizer())
        delegate.view.addGestureRecognizer(delegate.revealViewController().panGestureRecognizer())
    }
    
    func setUpMenuButton(delegate:UIViewController ,menuBtn: UIButton ){
        let menu = delegate.storyboard!.instantiateViewController(withIdentifier: "MenuVC")
        //menuBtn.tag = delegate.revealViewController()
        if LocalizationHelper.getAppLang() == "ar"{
            
            delegate.revealViewController().rearViewController = nil
            delegate.revealViewController().rightViewRevealWidth = delegate.view.frame.width - 50
            delegate.revealViewController().rightViewController = menu
            menuBtn.addTarget(SWRevealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
            //menuBtn.action =
        }
        else{
            delegate.revealViewController().rearViewRevealWidth = delegate.view.frame.width - 50
            delegate.revealViewController().rearViewController = menu
            delegate.revealViewController().rightViewController = nil
            menuBtn.addTarget(SWRevealViewController(), action:#selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            //menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        delegate.view.addGestureRecognizer(delegate.revealViewController().tapGestureRecognizer())
        delegate.view.addGestureRecognizer(delegate.revealViewController().panGestureRecognizer())
    }
}
