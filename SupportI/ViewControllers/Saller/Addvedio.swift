//
//  Addvedio.swift
//  Wndo
//
//  Created by Adam on 10/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addvedio: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        print("fffrfrhhhjrhjrjh")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (UserRoot.token() != nil){
            let vcc = self.pushViewController(Addvediooption.self,storyboard: .saller)
            pushPop(vcr: vcc)
            
        }else{
            let vcc = self.pushViewController(GuestPopUpViewController.self,storyboard: .main)
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        
    }


}
extension Addvedio : BuyerswitchDelegate , GuestPopUpDelegate {
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
