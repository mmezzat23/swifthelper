//
//  BaseViewControllerProtocol.swift
//  FashonDesign
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewControllerProtocol {
    func setup()
    func setupBase()
    func initViewController(_ indetifier: String, storyboard: Storyboards )-> UIViewController
    func pushViewController<T>(_ indetifier: T.Type, storyboard: Storyboards )->T
    func controller<T>(_ indetifier: T.Type, storyboard: Storyboards )->T
    func initNavigationController (_ indetifier: String ,storyboard: Storyboards )-> UINavigationController
    func push(_ view: UIViewController, _ animated: Bool)
}
extension BaseViewControllerProtocol where Self: BaseController {
    func setup(){
        
    }
    func initViewController(_ indetifier: String ,storyboard: Storyboards = Storyboards.main) -> UIViewController {
        
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: indetifier)
        return vc
    }
    func initNavigationController(_ indetifier: String ,storyboard: Storyboards = Storyboards.main) -> UINavigationController {
        
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: indetifier) as! UINavigationController
        return vc
    }
    func pushViewController<T>(_ indetifier: T.Type ,storyboard: Storyboards = Storyboards.main) ->T {
        
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: String(describing: indetifier))
        return vc as! T
    }
    func controller<T>(_ indetifier: T.Type ,storyboard: Storyboards = Storyboards.main) -> T {
        
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: String(describing: indetifier))
        return vc as! T
    }
    func push(_ view:UIViewController,_ animated:Bool = true)  {
        self.navigationController?.delegate = self
        view.transitioningDelegate = self
        self.navigationController?.pushViewController(view, animated: animated)
    }
    
}
