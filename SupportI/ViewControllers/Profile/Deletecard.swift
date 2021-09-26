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
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        name.text = "\("You want to delete the credit card ends with".localized()) ****\(txt.prefix(12))?"
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
        viewModel?.deletecard(id: id)
    }
    @IBAction func discard(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
