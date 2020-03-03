//
//  Alertable.swift
//  SupportI
//
//  Created by mohamed abdo on 7/30/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

protocol Alertable: class {
    func makeAlert(_ message: String, closure: @escaping () -> Void )
    func createActionSheet(title: String, actions: [String: Any], closure: @escaping ([String: Any]) -> Void )
}

extension Alertable {
    func makeAlert(_ message: String, closure: @escaping () -> Void ) {
        let alert = UIAlertController(title: "alert.lan".localized, message: message, preferredStyle: UIAlertController.Style.alert)
        let acceptAction = UIAlertAction(title: "sure.lan".localized, style: .default) { (_) -> Void in
            closure()
        }
        let cancelAction = UIAlertAction(title: "cancel.lan".localized, style: .default) { (_) -> Void in
        }
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    func createActionSheet(title: String, actions: [String: Any], closure: @escaping ([String: Any]) -> Void ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for (key, value) in actions {
            alert.addAction(UIAlertAction(title: key, style: .default, handler: { _ in
                closure([key: value])
            }))
        }
        alert.addAction(UIAlertAction.init(title: "cancel.lan".localized, style: .cancel, handler: nil))
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.permittedArrowDirections = .up
            alert.popoverPresentationController?.sourceView = UIApplication.topMostController().view
        default:
            break
        }
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
