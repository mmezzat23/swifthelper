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
    func pushPop(vc:UIViewController)
    func topMostController() -> UIViewController
}

extension POPUPView where Self:UIViewController {
    
    func pushPop(vc:UIViewController)  {
        //show window
        vc.modalPresentationStyle = .overFullScreen
        //present(vc, animated: true, completion: nil)
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        let topVC = UIApplication.topMostController()
        topVC.present(vc, animated: true, completion: nil)
        
        //appDelegate.window?.rootViewController = vc
        
    }
    
    func topMostController() -> UIViewController {
        return UIApplication.topMostController()
    }
}

