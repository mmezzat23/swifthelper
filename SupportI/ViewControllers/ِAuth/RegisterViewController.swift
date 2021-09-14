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
    var isPhoneNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
    }
    @IBAction func loginClicked(_ sender: UIButton) {
        let scene = self.controller(LoginController.self,storyboard: .auth)
        self.push(scene)
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
        if emialOrPhoneTxt.text?.isNumeric == true {
            parameters["phone"] = emialOrPhoneTxt.text ?? ""
            isPhoneNumber =  true
        } else {
            parameters["email"] =  emialOrPhoneTxt.text ?? ""
            isPhoneNumber =  false
        }
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
        if !isPhoneNumber {
            emialOrPhoneTxt.customValidationRules = [RequiredRule() , EmailRule()]
        } else {
            emialOrPhoneTxt.customValidationRules = [RequiredRule() , MinLengthRule(length: 11)]
        }
        userNameTxt.customValidationRules = [RequiredRule() , MaxLengthRule(length: 16)]
        passwordTxt.customValidationRules = [RequiredRule(), MinLengthRule(length: 8)]
        let validator = Validation(textFields: [emialOrPhoneTxt , userNameTxt ,passwordTxt])
        return validator.success
    }
    
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
   }
    
    func signUp() {
        parameters["username"] = userNameTxt.text ?? ""
        parameters["password"] = passwordTxt.text ?? ""
        parameters["scope"] = "WndoApp offline_access"
        parameters["grant_type"] = "password"
        viewModel?.RegisterApi(paramters: parameters)
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            let scene = self?.controller(CodeverficationController.self,storyboard: .main)
            scene?.isCommingFromForgetPassword = false
            scene?.userName =  self?.userNameTxt.text ?? ""
            scene?.sendTo = self?.emialOrPhoneTxt.text ?? ""
            self?.push(scene!)
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    
}

