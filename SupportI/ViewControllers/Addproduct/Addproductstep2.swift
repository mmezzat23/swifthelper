//
//  Addproductstep2.swift
//  Wndo
//
//  Created by Adam on 11/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addproductstep2: BaseController {
    @IBOutlet weak var delivarymethod: UITextField!
    @IBOutlet weak var address: UIView!
    @IBOutlet weak var imgaddress: UIImageView!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var time: UIView!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var times: UICollectionView!
    var productid = ""
    var catid = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addnewaddress(_ sender: Any) {
    }
    @IBAction func `continue`(_ sender: Any) {
    }
    @IBAction func savedraft(_ sender: Any) {
    }
    
}
