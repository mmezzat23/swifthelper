//
//  Alertable.swift
//  SupportI
//
//  Created by mohamed abdo on 7/30/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import Foundation

protocol Alertable: class {
    func makeAlert(_ message:String, closure:@escaping ()->() )
}

extension Alertable {
    func makeAlert(_ message:String, closure:@escaping ()->() ) {
        
        let alert = UIAlertController(title: translate("alert"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        let acceptAction = UIAlertAction(title: translate("sure"), style: .default) { (_) -> Void in
            closure()
        }
        let cancelAction = UIAlertAction(title: translate("cancel"), style: .default) { (_) -> Void in
        }
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        
        
    }
}
