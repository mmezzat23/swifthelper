//
//  Addvediooption.swift
//  Wndo
//
//  Created by Adam on 10/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addvediooption: BaseController {
    @IBOutlet weak var live: UIView!
    @IBOutlet weak var vedio: UIView!
    @IBOutlet weak var product: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        self.view.UIViewAction {
            self.dismiss(animated: true) { [self] in
            }
        }
    }
    
}
