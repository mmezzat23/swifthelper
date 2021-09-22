//
//  About.swift
//  SupportI
//
//  Created by Adam on 9/21/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class About: BaseController {
    @IBOutlet weak var txt: UILabel!
    @IBOutlet weak var more: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        more.setunderline(title: "For More Details, please visit us")
//        For More Details, please visit us
        // Do any additional setup after loading the view.
    }
    
    @IBAction func website(_ sender: Any) {
    }
    
    @IBAction func twitt(_ sender: Any) {
    }
    
    @IBAction func face(_ sender: Any) {
    }
}
