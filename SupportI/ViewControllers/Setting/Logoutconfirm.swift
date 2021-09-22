//
//  Logoutconfirm.swift
//  SupportI
//
//  Created by Adam on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Logoutconfirm: BaseController {
    var timerHelper: TimeHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            self.dismiss(animated: true, completion: nil)
            let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
                   guard let nav = controller else { return }
                   let delegate = UIApplication.shared.delegate as? AppDelegate
                   delegate?.window?.rootViewController = nav
        }
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
