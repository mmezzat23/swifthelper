//
//  SocialError.swift
//  RedBricks
//
//  Created by Mohamed Abdu on 6/11/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

protocol SocialError {
    func alertError()
}
extension SocialError {
    func alertError() {
        let topVC = UIApplication.topMostController()
        let alert = UIAlertController(title: "your_are_cancel_the_operation.lan".localized,
                                      message: "you_must_accept_the_request_to_login.lan".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "sure.lan".localized, style: .cancel) { (_) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        topVC.present(alert, animated: false, completion: nil)
    }
}
