//
//  Addvedio.swift
//  Wndo
//
//  Created by Adam on 12/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addvedios: BaseController {
    @IBOutlet weak var vediolbl: UITextField!
    @IBOutlet weak var vediodes: UITextField!
    
    @IBOutlet weak var tags: UITextField!
    @IBOutlet weak var selectvedio: UILabel!
    @IBOutlet weak var product: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func `continue`(_ sender: Any) {
    }
    

    @IBAction func address(_ sender: Any) {
    }
}
