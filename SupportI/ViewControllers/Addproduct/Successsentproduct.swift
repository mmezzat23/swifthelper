//
//  Successsentproduct.swift
//  Wndo
//
//  Created by Adam on 12/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Successsentproduct: BaseController {
var txt = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addnewproduct(_ sender: Any) {
        let vcc = self.controller(Addproduct.self,storyboard: .addproduct)
        self.push(vcc)
    }
    
    @IBAction func store(_ sender: Any) {
        Constants.index = 1
        let controller = UIStoryboard(name: "Saller", bundle: nil).instantiateInitialViewController()
            guard let nav = controller else { return }
            let delegate = UIApplication.shared.delegate as? AppDelegate
            delegate?.window?.rootViewController = nav

    }
    
}
