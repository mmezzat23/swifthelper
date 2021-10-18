//
//  Sorryactive.swift
//  Wndo
//
//  Created by Adam on 11/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Sorryactive: BaseController {
    @IBOutlet weak var txt: UILabel!
    var txtstring = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (txtstring != ""){
            txt.text = txtstring
        }

    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
