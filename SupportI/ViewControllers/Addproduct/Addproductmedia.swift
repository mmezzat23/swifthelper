//
//  Addproductmedia.swift
//  Wndo
//
//  Created by Adam on 19/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addproductmedia: BaseController {
    @IBOutlet weak var viewvedio: UIView!
    @IBOutlet weak var play: UIImageView!
    
    @IBOutlet weak var continu: UIButton!
    @IBOutlet weak var savedraft: UIButton!
    @IBOutlet weak var vediohight: NSLayoutConstraint!
    @IBOutlet weak var vedioline: UIView!
    @IBOutlet weak var vediolinehight: NSLayoutConstraint!
    @IBOutlet weak var vedios: UICollectionView!
    @IBOutlet weak var photos: UICollectionView!
    @IBOutlet weak var delete: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func `continue`(_ sender: Any) {
    }
    
    @IBAction func savedraft(_ sender: Any) {
    }
    
}
