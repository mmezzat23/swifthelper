//
//  Reviewproduct.swift
//  Wndo
//
//  Created by Adam on 19/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import BMPlayer

class Reviewproduct: BaseController {
    @IBOutlet weak var taxes: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var commisionlbl: UILabel!
    @IBOutlet weak var dicountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var buyerprice: UILabel!
    @IBOutlet weak var pricesummary: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var productdep: UILabel!
    @IBOutlet weak var productdes: UILabel!
    @IBOutlet weak var player: BMPlayer!
    @IBOutlet weak var photos: UICollectionView!
    @IBOutlet weak var productinfo: UITableView!
    
    @IBOutlet weak var dateview: UIView!
    @IBOutlet weak var datehight: NSLayoutConstraint!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var pricetxtlbl: UILabel!
    @IBOutlet weak var discountlbl: UILabel!
    @IBOutlet weak var picktimelbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var delivarylbl: UILabel!
    @IBOutlet weak var sizeview: UIView!
    @IBOutlet weak var sizehight: NSLayoutConstraint!
    @IBOutlet weak var sizes: UITableView!
    var productid = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editprice(_ sender: Any) {
    }
    @IBAction func editship(_ sender: Any) {
    }
    @IBAction func editinfo(_ sender: Any) {
    }
    @IBAction func editmedia(_ sender: Any) {
    }
    @IBAction func editname(_ sender: Any) {
    }
    
    @IBAction func edit(_ sender: Any) {
    }
    @IBAction func post(_ sender: Any) {
    }
    
}
