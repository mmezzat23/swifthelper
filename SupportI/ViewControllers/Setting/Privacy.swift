//
//  Privacy.swift
//  SupportI
//
//  Created by Adam on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Privacy: BaseController {
    @IBOutlet weak var txt: UITextView!
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    var type = 0
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet var banner: UIView!
    
    @IBOutlet weak var notify: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (type == 2){
            titlelbl.text = "Request A Refund".localized()
        }
        setup()
        bind()
        if (UserRoot.saller() == true){
            banner.backgroundColor = UIColor(red: 01, green: 14, blue: 47)
            notify.setImage(#imageLiteral(resourceName: "notify"), for: .normal)
        }
    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
       parameters["isSeller"] = UserRoot.saller()
       parameters["dto"] = type
       viewModel?.getinfo(paramters: parameters)
   }
    
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.txt.text = data.responseData?.text?.htmlToString
           
        })
        
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }

}
