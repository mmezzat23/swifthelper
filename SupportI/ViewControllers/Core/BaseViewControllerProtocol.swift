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
    func initViewController(_ indetifier: String, storyboard: Storyboards ) -> UIViewController
    func pushViewController<T>(_ indetifier: T.Type, storyboard: Storyboards ) -> T
    func controller<T>(_ indetifier: T.Type, storyboard: Storyboards ) -> T
    func initNavigationController (_ indetifier: String, storyboard: Storyboards ) -> UINavigationController
    func push(_ view: UIViewController, _ animated: Bool)
}
extension BaseViewControllerProtocol where Self: BaseController {
    func setup() {

    }
    func initViewController(_ indetifier: String, storyboard: Storyboards = Storyboards.main) -> UIViewController {

        let storyboard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vcr: UIViewController = storyboard.instantiateViewController(withIdentifier: indetifier)
        return vcr
    }
    func initNavigationController(_ indetifier: String, storyboard: Storyboards = Storyboards.main) -> UINavigationController {

        let storyboard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let vcr: UINavigationController = storyboard.instantiateViewController(withIdentifier: indetifier)
            as? UINavigationController else { return UINavigationController() }
        return vcr
    }
    func pushViewController<T>(_ indetifier: T.Type, storyboard: Storyboards = Storyboards.main) -> T {

        let storyboard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vcr: UIViewController = storyboard.instantiateViewController(withIdentifier: String(describing: indetifier))
        if let controller = vcr as? T {
            return controller
        } else {
            fatalError("Controller failed while casting")
        }
    }
    func controller<T>(_ indetifier: T.Type, storyboard: Storyboards = Storyboards.main) -> T {

        let storyboard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vcr: UIViewController = storyboard.instantiateViewController(withIdentifier: String(describing: indetifier))
        if let controller = vcr as? T {
            return controller
        } else {
            fatalError("Controller failed while casting")
        }
    }
    func push(_ view: UIViewController, _ animated: Bool = true) {
        self.navigationController?.delegate = self
        view.transitioningDelegate = self
        self.navigationController?.pushViewController(view, animated: animated)
    }

}
