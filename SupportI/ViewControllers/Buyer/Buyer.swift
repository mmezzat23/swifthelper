//
//  Buyer.swift
//  SupportI
//
//  Created by Adam on 9/28/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Buyer: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (UserRoot.token() != nil){
            let vcc = self.pushViewController(Buyerswitch.self,storyboard: .main)
            vcc.delegate = self
            pushPop(vcr: vcc)
            
        }else{
            let vcc = self.pushViewController(GuestPopUpViewController.self,storyboard: .main)
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        
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
extension Buyer : BuyerswitchDelegate , GuestPopUpDelegate {
    func settype(type: String?) {
        if (type == "terms"){
            let vcc = self.controller(Terms.self,storyboard: .setting)
            self.push(vcc)
        }else if (type == "contact"){
            let vcc = self.controller(Contactus.self,storyboard: .setting)
            self.push(vcc)
        }else if (type == "signup"){
            let vcc = self.controller(RegisterViewController.self,storyboard: .auth)
            self.push(vcc)
        }
    }
    
    
}
