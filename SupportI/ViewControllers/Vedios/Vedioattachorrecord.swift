//
//  Vedioattachorrecord.swift
//  Wndo
//
//  Created by Adam on 14/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Vedioattachorrecord: BaseController {
    var parameters : [String : Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

    }
    

    @IBAction func uploadvedio(_ sender: Any) {
        let vcc = self.controller(Vediocache.self,storyboard: .vedios)
        vcc.parameters = self.parameters
        self.pushPop(vcr: vcc)
    }
    @IBAction func startrecord(_ sender: Any) {
        let vcc = self.controller(Recordeing.self,storyboard: .vedios)
        vcc.parameters = self.parameters
        self.push(vcc)
    }
    
}
