//
//  ConfirmpassController.swift
//  SupportI
//
//  Created by Adam on 9/13/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class ConfirmpassController: BaseController {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signup: UIStackView!
    var viewModel : AuthViewModel?
    var parameters : [String : Any] = [:]
    var userid = ""
    
    @IBOutlet weak var lock: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        signup.UIViewAction {
            let vcc = self.controller(RegisterViewController.self,storyboard: .auth)
            self.push(vcc)
        }
        password.setLeftPaddingPoints(10)
        password.setRightPaddingPoints(10)

    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
        lock.UIViewAction { [self] in
            if (password.isSecureTextEntry){
                password.isSecureTextEntry = false
            }else{
                password.isSecureTextEntry = true
            }
        }
   }
   
   override func bind() {
       viewModel?.userdata.bind({ [weak self](data) in
           self?.stopLoading()
           let scene = self?.controller(PassconfirmController.self,storyboard: .auth1)
           self?.push(scene!)
       })
       viewModel?.errordata.bind({ [weak self](data) in
           self?.stopLoading()
           print(data)
           self?.makeAlert(data, closure: {})
           
       })
   }
    func validateTextFields() -> Bool {
        
        password.customValidationRules = [RequiredRule(), MinLengthRule(length: 8) , PasswordRule()]
        let validator = Validation(textFields: [password])
        return validator.success
    }
    @IBAction func confirm(_ sender: Any) {
        if (validateTextFields()){
            parameters["userId"] = self.userid
            parameters["password"] = password.text
            print(parameters)
            viewModel?.resetapi(paramters:parameters)
        }
    }

}
