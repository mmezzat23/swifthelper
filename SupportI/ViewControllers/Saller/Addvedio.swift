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
        self.tabBarController?.tabBar.isHidden = false
        if (UserRoot.token() != nil){
            let vcc = self.pushViewController(Addvediooption.self,storyboard: .saller)
            vcc.delegate = self
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

extension Addvedio : AddvediooptionDelegate {
    func settype(type: String?, isvalid: Bool, hasproduct: Bool) {
        if (type == "live"){
            if (isvalid){
                if (hasproduct == false){
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                    let vcc = self.pushViewController(Sorryactive.self,storyboard: .saller)
                    pushPop(vcr: vcc)
                    }
                }else {
                    
                }
            }else {
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                let vcc = self.pushViewController(Sorryactive.self,storyboard: .saller)
                vcc.txtstring = "You will not be able to go live before you are active to be saller".localized()
                pushPop(vcr: vcc)
                }
            }
        }else if (type == "vedio"){
            if (isvalid){
                if (hasproduct == false){
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                    let vcc = self.pushViewController(Sorryactive.self,storyboard: .saller)
                    pushPop(vcr: vcc)
                    }
                }else {
                let vcc = self.controller(Addvedios.self,storyboard: .vedios)
                self.push(vcc)
                }
            }else {
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                let vcc = self.pushViewController(Sorryactive.self,storyboard: .saller)
                vcc.txtstring = "You will not be able to add video before you are active to be saller".localized()
                pushPop(vcr: vcc)
                }
            }
        }else if (type == "product"){
            if (isvalid){
                let vcc = self.controller(Addproduct.self,storyboard: .addproduct)
                self.push(vcc)
            }else {
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                let vcc = self.pushViewController(Sorryactive.self,storyboard: .saller)
                vcc.txtstring = "You will not be able to add product before you are active to be saller".localized()
                pushPop(vcr: vcc)
                }
            }
        }
    }
    
    
}
