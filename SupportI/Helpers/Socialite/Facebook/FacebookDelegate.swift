//
//  FacebookDelegate.swift
//  RedBricks
//
//  Created by Mohamed Abdu on 6/11/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import FBSDKCoreKit
extension AppDelegate {
    func initFB(application : UIApplication , options:[UIApplication.LaunchOptionsKey: Any]?) {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: options)
    }
}
