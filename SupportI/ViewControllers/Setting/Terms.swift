//
//  Terms.swift
//  SupportI
//
//  Created by Adam on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Terms: BaseController {
    @IBOutlet weak var txt: UITextView!
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
       parameters["isSeller"] = UserRoot.saller()
       parameters["dto"] = 3
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
