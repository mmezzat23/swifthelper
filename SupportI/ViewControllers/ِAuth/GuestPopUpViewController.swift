//
//  GuestPopUpViewController.swift
//  SupportI
//
//  Created by Kareem on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class GuestPopUpViewController: BaseController {

    @IBOutlet weak var sendmessage: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        sendmessage.UIViewAction {
            self.dismiss(animated: true, completion: nil)
         guard let vcr = Constants.contactNav else { return }
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
         appDelegate?.window?.rootViewController = vcr

        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func login(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
        guard let vcr = Constants.loginNav else { return }
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = vcr

    }
    
    @IBAction func signup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
     guard let vcr = Constants.regNav else { return }
     let appDelegate = UIApplication.shared.delegate as? AppDelegate
     appDelegate?.window?.rootViewController = vcr


    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
