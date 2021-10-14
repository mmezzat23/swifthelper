//
//  Store.swift
//  Wndo
//
//  Created by Adam on 14/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Store: BaseController {
    @IBOutlet weak var offers: UIView!
    @IBOutlet weak var offerlbl: UILabel!
    @IBOutlet weak var offerline: UIView!
    @IBOutlet weak var product: UIView!
    @IBOutlet weak var productlbl: UILabel!
    @IBOutlet weak var productline: UIView!
    @IBOutlet weak var vedios: UIView!
    @IBOutlet weak var vedioslbl: UILabel!
    @IBOutlet weak var vediosline: UIView!
    @IBOutlet weak var searchtxt: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var noresult: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
    }
    
    @IBAction func filter(_ sender: Any) {
    }
    

}
