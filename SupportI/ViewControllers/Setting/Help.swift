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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        onclick()

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
            self.push(vcc)
        }
        sendmessage.UIViewAction {
            let vcc = self.controller(Contactus.self,storyboard: .setting)
            self.push(vcc)
        }
    }
}
