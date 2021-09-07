//
//  POPUPViewController.swift
//  RedBricks
//
//  Created by mohamed abdo on 6/2/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

protocol POPUPView {
    func pushPop(vcr: UIViewController)
    func topMostController() -> UIViewController
}

extension POPUPView where Self: UIViewController {

    func pushPop(vcr: UIViewController) {
        //show window
        vcr.modalPresentationStyle = .overFullScreen
        //present(vc, animated: true, completion: nil)
        vcr.view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        let topVC = UIApplication.topMostController()
        topVC.present(vcr, animated: true, completion: nil)

        //appDelegate.window?.rootViewController = vc

    }

    func topMostController() -> UIViewController {
        return UIApplication.topMostController()
    }
}
