//
//  Samplesaller.swift
//  Wndo
//
//  Created by Adam on 12/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Samplesaller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
