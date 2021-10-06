//
//  Changesuccess.swift
//  Wndo
//
//  Created by Adam on 10/6/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol ChangesuccessDelegate: class {
    func settype()
}
class Changesuccess: BaseController {
    @IBOutlet weak var txt: UILabel!
    var txtstring = ""
    var delegate : ChangesuccessDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (txtstring != ""){
            txt.text = txtstring
        }
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            self.dismiss(animated: true, completion: nil)
            self.delegate?.settype()
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
