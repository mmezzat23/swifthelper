//
//  Deletecard.swift
//  SupportI
//
//  Created by Adam on 9/23/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Deletecard: BaseController {
    var id = 0 ;
    var viewModel : ProfileViewModel?
    var txt = ""
    var type = ""
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        if (type == "1"){
            titlelbl.text = "Delete address".localized
            name.text = "\("You want to delete the address that name".localized()) \(txt)?"
        }else{
            let index = txt.index(txt.endIndex, offsetBy: -4)
            let mySubstring = txt.suffix(from: index) // playground
        name.text = "\("You want to delete the credit card ends with".localized()) ****\(mySubstring)?"
        }
    }
    
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
    }
    override func bind() {
        viewModel?.deletedata.bind({ [weak self](data) in
            self?.stopLoading()
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                   guard let nav = controller else { return }
                   let delegate = UIApplication.shared.delegate as? AppDelegate
                   delegate?.window?.rootViewController = nav
            self?.dismiss(animated: true, completion: nil)
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }

    @IBAction func yes(_ sender: Any) {
        if (type == "1"){
        viewModel?.deleteaddress(id: id)
        }else{
        viewModel?.deletecard(id: id)
        }
    }
    @IBAction func discard(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}