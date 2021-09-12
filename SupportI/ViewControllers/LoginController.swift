//
//  Login.swift
//  SupportI
//
//  Created by Adam on 9/9/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class LoginController: BaseController {
    var viewModel : AuthViewModel?
    var parameters : [String : Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        makelogin()

        // Do any additional setup after loading the view.
    }
     func setup() {
        viewModel = .init()
        viewModel?.delegate = self
    }
    
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
//            guard let scene = UIStoryboard(name: Storyboards.main.rawValue, bundle: nil).instantiateInitialViewController() else { return }
//            self?.push(scene)
            
        })
    }
    
    func makelogin() {
        parameters["username"] = "admin"
        parameters["password"] = "1q2w3E*"
        parameters["scope"] = "WndoApp offline_access"
        parameters["grant_type"] = "password"
        viewModel?.loginapi(paramters:parameters)
    }
    

   
}
