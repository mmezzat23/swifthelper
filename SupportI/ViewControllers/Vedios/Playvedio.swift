//
//  Playvedio.swift
//  Wndo
//
//  Created by Adam on 26/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import BMPlayer
class Playvedio: BaseController {
    var playid = ""
    @IBOutlet weak var player: BMPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        let asset = BMPlayerResource(url: URL(string: playid)!,
                                              name: "WNDO")
        self.player.setVideo(resource: asset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
    }

}
