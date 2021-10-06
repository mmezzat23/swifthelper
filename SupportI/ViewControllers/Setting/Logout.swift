//
//  Logout.swift
//  SupportI
//
//  Created by Adam on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Logout: BaseController {
    @IBOutlet weak var yes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (UserRoot.saller() == true){
            yes.backgroundColor = UIColor(red: 01, green: 14, blue: 47)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func skip(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        UserRoot.save(response: Data())
        UserRoot.savesaller(remember: false)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){ [self] in
            let vcc = self.pushViewController(Logoutconfirm.self,storyboard: .setting)
            pushPop(vcr: vcc)
        }
        
    }
    
}
