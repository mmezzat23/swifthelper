//
//  Addcard.swift
//  SupportI
//
//  Created by Adam on 9/23/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import FormTextField

class Addcard: BaseController {
    @IBOutlet weak var cardname: UITextField!
    @IBOutlet weak var visanumber: UITextField!
    @IBOutlet weak var visacardname: UILabel!
    @IBOutlet weak var visaexpiry: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: FormTextField!
    @IBOutlet weak var expiry: FormTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
       
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    @IBAction func expirychange(_ sender: Any) {
        visaexpiry.text = expiry.text
    }
    
    @IBAction func namechange(_ sender: Any) {
        visacardname.text = name.text
    }
    
    @IBAction func numberchange(_ sender: Any) {
        visanumber.text = number.text
    }
    
    

}


