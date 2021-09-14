//
//  RegisterViewController.swift
//  SupportI
//
//  Created by Kareem on 9/13/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class RegisterViewController: BaseController {
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emialOrPhoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    var viewModel : Auth1ViewModel?
    var parameters : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    @IBAction func loginClicked(_ sender: UIButton) {
        let scene = self.controller(LoginController.self,storyboard: .auth)
        self.push(scene)
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
        if (validateTextFields()) {
            signUp()
        }
    }
    @IBAction func signUpWithAppleClicked(_ sender: UIButton) {
    }
    @IBAction func signUpWithGoogleClicked(_ sender: UIButton) {
    }
    
    @IBAction func signUpWithFacebookClicked(_ sender: UIButton) {
    }
    func validateTextFields() -> Bool {
        emialOrPhoneTxt.customValidationRules = [RequiredRule() , EmailRule()]
        userNameTxt.customValidationRules = [RequiredRule()]
        passwordTxt.customValidationRules = [RequiredRule(), MinLengthRule(length: 6)]
        let validator = Validation(textFields: [emialOrPhoneTxt,passwordTxt])
        return validator.success
    }
    
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
   }
    
    func signUp() {
        parameters["username"] = userNameTxt.text ?? ""
        parameters["email"] = emialOrPhoneTxt.text ?? ""
        parameters["phone"] = emialOrPhoneTxt.text ?? ""
        parameters["password"] = passwordTxt.text ?? ""
        parameters["scope"] = "WndoApp offline_access"
        parameters["grant_type"] = "password"
        viewModel?.RegisterApi(paramters: parameters)
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
        })
    }
    
}
