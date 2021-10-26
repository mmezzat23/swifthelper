//
//  Deletesuccess.swift
//  Wndo
//
//  Created by Adam on 10/6/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol DeletesuccessDelegate: class {
    func settype()
}
class Deletesuccess: BaseController {
    @IBOutlet weak var txt: UILabel!
    var type = ""
    var delegate : DeletesuccessDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (type == "1"){
            txt.text = "Your address deleted".localized
        }else  if (type == "product"){
            txt.text = "Your product deleted".localized
        }else  if (type == "vedio"){
            txt.text = "Your vedio deleted".localized
        }
    }
    
    @IBAction func done(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
            delegate?.settype()
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
