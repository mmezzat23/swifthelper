//
//  Help.swift
//  SupportI
//
//  Created by Adam on 9/21/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Help: BaseController {
    @IBOutlet weak var about: UIView!
    @IBOutlet weak var faq: UIView!
    @IBOutlet weak var request: UIView!
    @IBOutlet weak var terms: UIView!
    @IBOutlet weak var privacy: UIView!
    @IBOutlet weak var logout: UIView!
    @IBOutlet weak var sendmessage: UIView!
    @IBOutlet weak var logouthight: NSLayoutConstraint!
    
    @IBOutlet weak var banner: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (UserRoot.saller() == true){
            banner.backgroundColor = UIColor(red: 01, green: 14, blue: 47)
        }
        onclick()
        if (UserRoot.token() == nil){
            logouthight.constant = 0
            logout.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    func onclick() {
        about.UIViewAction {
            let vcc = self.controller(About.self,storyboard: .setting)
            self.push(vcc)
        }
        faq.UIViewAction {
            let vcc = self.controller(Faq.self,storyboard: .setting)
            self.push(vcc)
        }
        terms.UIViewAction {
            let vcc = self.controller(Terms.self,storyboard: .setting)
            self.push(vcc)
        }
        privacy.UIViewAction {
            let vcc = self.controller(Privacy.self,storyboard: .setting)
            vcc.type = 4
            self.push(vcc)
        }
        request.UIViewAction {
            let vcc = self.controller(Privacy.self,storyboard: .setting)
            vcc.type = 2
            self.push(vcc)
        }
        sendmessage.UIViewAction {
            let vcc = self.controller(Contactus.self,storyboard: .setting)
            self.push(vcc)
        }
        logout.UIViewAction { [self] in
            let vcc = self.pushViewController(Logout.self,storyboard: .setting)
            pushPop(vcr: vcc)
        }
    }
}
