//
//  Editdeleteoption.swift
//  Wndo
//
//  Created by Adam on 10/5/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol EditdeleteoptionDelegate: class {
    func settype(type: String? , action : String?)
}
class Editdeleteoption: BaseController {
    @IBOutlet weak var edit: UIView!
    @IBOutlet weak var delete: UIView!
    @IBOutlet weak var edittxt: UILabel!
    @IBOutlet weak var deletetxt: UILabel!
    var type = ""
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    var isedit = false
    var id = 0
    var num = ""
    var expirytxt = ""
    var cardtxt = ""
    var nametxt = ""
    var isdefultvalue = false
    var lat : Double = 0
    var lng : Double = 0
    var cityid = 0
    var isdefult = false
    var txt = ""
    weak var delegate: EditdeleteoptionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (type == "2"){
            edittxt.text = "Edit The credit card".localized()
            deletetxt.text = "Delete The credit card".localized()
        }else if (type == "vedio"){
            edittxt.text = "Edit The vedio".localized()
            deletetxt.text = "Delete The vedio".localized()
        }else if (type == "product"){
            edittxt.text = "Edit The product".localized()
            deletetxt.text = "Delete The product".localized()
        }
        edit.UIViewAction { [self] in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.settype(type: type, action: "edit")
        }
        delete.UIViewAction { [self] in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.settype(type: type, action: "delete")
        }
        view.UIViewAction {
            self.dismiss(animated: true, completion: nil)

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
