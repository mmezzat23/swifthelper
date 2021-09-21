//
//  Profilebuyer.swift
//  SupportI
//
//  Created by Adam on 9/21/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import Cosmos
class Profilebuyer: BaseController {
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var followingnum: UILabel!
    @IBOutlet weak var followernum: UILabel!
    @IBOutlet weak var likenum: UILabel!
    @IBOutlet weak var notification: UIView!
    @IBOutlet weak var notnum: UILabel!
    @IBOutlet weak var wishlist: UIView!
    @IBOutlet weak var address: UIView!
    @IBOutlet weak var order: UIView!
    @IBOutlet weak var payment: UIView!
    @IBOutlet weak var setting: UIView!
    @IBOutlet weak var help: UIView!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        onclick()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func edit(_ sender: Any) {
    }
    @IBAction func calender(_ sender: Any) {
    }
    
    @IBAction func back(_ sender: Any) {
    }
    
    func onclick(){
        help.UIViewAction {
            let vcc = self.controller(Help.self,storyboard: .setting)
            self.push(vcc)
        }
    }
}
