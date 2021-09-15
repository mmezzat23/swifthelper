//
//  ForgetpassController.swift
//  SupportI
//
//  Created by Adam on 9/13/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class ForgetpassController: BaseController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var signup: UIStackView!
    var viewModel : AuthViewModel?
    var parameters : [String : Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        signup.UIViewAction {
            let vcc = self.controller(RegisterViewController.self,storyboard: .auth)
            self.push(vcc)
        }

        // Do any additional setup after loading the view.
    }
     func setup() {
        viewModel = .init()
        viewModel?.delegate = self
    }
    
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            let scene = self?.controller(CodeverficationController.self,storyboard: .auth1)
            scene?.parameters = self!.parameters
            scene?.isCommingFromForgetPassword = true
            scene?.userid =  data.responseData?.userId ?? ""
            scene?.sendTo = self?.email.text ?? ""
            self?.push(scene!)
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
            
        })
    }
    
    @IBAction func send(_ sender: Any) {
        parameters["emailOrPhone"] = email.text
        viewModel?.forgetapi(paramters:parameters)
    }
    
    

}
