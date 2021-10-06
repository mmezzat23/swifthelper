//
//  Changesuccess.swift
//  Wndo
//
//  Created by Adam on 10/6/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Changesuccess: BaseController {
    @IBOutlet weak var txt: UILabel!
    var txtstring = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (txtstring != ""){
            txt.text = txtstring
        }
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            self.dismiss(animated: true, completion: nil)
            if (UserRoot.saller() == false){
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                   guard let nav = controller else { return }
                   let delegate = UIApplication.shared.delegate as? AppDelegate
                   delegate?.window?.rootViewController = nav
            }else {
                let controller = UIStoryboard(name: "Saller", bundle: nil).instantiateInitialViewController()
                       guard let nav = controller else { return }
                       let delegate = UIApplication.shared.delegate as? AppDelegate
                       delegate?.window?.rootViewController = nav
            }
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
