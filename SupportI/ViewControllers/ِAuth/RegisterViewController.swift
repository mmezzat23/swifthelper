//
//  RegisterViewController.swift
//  SupportI
//
//  Created by Kareem on 9/13/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
   
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emialOrPhoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!

    
    var viewModel : Auth1ViewModel?
    var parameters : [String : Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginClicked(_ sender: UIButton) {
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
        signUp()
    }

    @IBAction func signUpWithAppleClicked(_ sender: UIButton) {
    }
    @IBAction func signUpWithGoogleClicked(_ sender: UIButton) {
    }
    
    @IBAction func signUpWithFacebookClicked(_ sender: UIButton) {
    }

    func signUp() {
        
        emialOrPhoneTxt.customValidationRules = [RequiredRule() , EmailRule()]
        passwordTxt.customValidationRules = [RequiredRule(), MinLengthRule(length: 6)]
        parameters["username"] = userNameTxt.text ?? ""
        parameters["email"] = emialOrPhoneTxt.text ?? ""
        parameters["phone"] = emialOrPhoneTxt.text ?? ""
        parameters["password"] = passwordTxt.text ?? ""
        parameters["scope"] = "WndoApp offline_access"
        parameters["grant_type"] = "password"
        viewModel?.RegisterApi(paramters: parameters)
    }
    func bind() {
       viewModel?.userdata.bind({ [weak self](data) in
           self?.stopLoading()
           print(data)
       })
   }
    
}
