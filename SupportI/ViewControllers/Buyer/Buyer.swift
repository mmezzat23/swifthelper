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
        let vcc = self.pushViewController(Buyerswitch.self,storyboard: .main)
        pushPop(vcr: vcc)
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
