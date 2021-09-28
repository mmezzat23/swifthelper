//
//  Buyerswitch.swift
//  SupportI
//
//  Created by Adam on 9/28/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Buyerswitch: BaseController {
    @IBOutlet weak var accountmode: UILabel!
    @IBOutlet weak var switchmode: UILabel!
    @IBOutlet weak var terms: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        terms.setunderline(title: "Privacy Policy and Terms.".localized())
        if (UserRoot.saller() == true){
            accountmode.text = "Seller Mode.".localized()
            switchmode.text = "Buyer Mode.".localized()
        }else{
            switchmode.text = "Seller Mode.".localized()
            accountmode.text = "Buyer Mode.".localized()
        }
        terms.UIViewAction {
            let vcc = self.controller(Terms.self,storyboard: .setting)
            self.push(vcc)
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func discard(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        if (UserRoot.saller() == true){
            UserRoot.savesaller(remember: false)
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                   guard let nav = controller else { return }
                   let delegate = UIApplication.shared.delegate as? AppDelegate
                   delegate?.window?.rootViewController = nav
            
        }else{
            UserRoot.savesaller(remember: true)
            let controller = UIStoryboard(name: "Saller", bundle: nil).instantiateInitialViewController()
                   guard let nav = controller else { return }
                   let delegate = UIApplication.shared.delegate as? AppDelegate
                   delegate?.window?.rootViewController = nav

        }
    }
  

}
