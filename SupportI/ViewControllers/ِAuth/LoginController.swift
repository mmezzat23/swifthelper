//
//  Login.swift
//  SupportI
//
//  Created by Adam on 9/9/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class LoginController: BaseController {
    
    @IBOutlet weak var emialOrPhoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
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
    
    @IBAction func forgetPasswordClicked(_ sender: UIButton) {
    }
    @IBAction func loginClicked(_ sender: UIButton) {
    }
    @IBAction func loginWithAppleClicked(_ sender: UIButton) {
    }
    @IBAction func loginWithGoogleClicked(_ sender: UIButton) {
    }
    
    @IBAction func loginWithFacebookClicked(_ sender: UIButton) {
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
    }
    @IBAction func rememberMeClicked(_ sender: UIButton) {
    }
    
    func makelogin() {
        parameters["username"] = "admin"
        parameters["password"] = "1q2w3E*"
        parameters["scope"] = "WndoApp offline_access"
        parameters["grant_type"] = "password"
        viewModel?.loginapi(paramters:parameters)
    }
    

   
}
