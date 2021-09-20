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
    @IBOutlet weak var forget: UIButton!
    
    var viewModel : AuthViewModel?
    var parameters : [String : Any] = [:]
    var isrember = false
    var attrs = [
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
    var attributedString = NSMutableAttributedString(string:"")
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        let buttonTitleStr = NSMutableAttributedString(string:"Forgot Password".localized, attributes:attrs)
        attributedString.append(buttonTitleStr)
        forget.setAttributedTitle(attributedString, for: .normal)
    }
     func setup() {
        viewModel = .init()
        viewModel?.delegate = self
    }
    
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            if (data.responseData?.isVerified == false){
                let scene = self?.controller(CodeverficationController.self,storyboard: .auth1)
                scene?.isCommingFromForgetPassword = false
                scene?.userName =  data.responseData?.userName ?? ""
                scene?.sendTo = self?.emialOrPhoneTxt.text ?? ""
                self?.push(scene!)
            }else {
            guard let scene = UIStoryboard(name: Storyboards.main.rawValue, bundle: nil).instantiateInitialViewController() else { return }
            self?.push(scene)
            }
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
            
        })
    }
    
    @IBAction func forgetPasswordClicked(_ sender: UIButton) {
        let vcc = self.controller(ForgetpassController.self,storyboard: .auth1)
        self.push(vcc)
    }
    @IBAction func loginClicked(_ sender: UIButton) {
        if (validateTextFields()){
            makelogin()
        }
    }
    @IBAction func loginWithAppleClicked(_ sender: UIButton) {
    }
    @IBAction func loginWithGoogleClicked(_ sender: UIButton) {
    }
    
    @IBAction func loginWithFacebookClicked(_ sender: UIButton) {
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
        let vcc = self.controller(RegisterViewController.self,storyboard: .auth)
        self.push(vcc)
    }
    @IBAction func rememberMeClicked(_ sender: UIButton) {
        if (isrember == true){
            sender.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
            isrember = false
        }else{
            sender.setImage(#imageLiteral(resourceName: "Check Box"), for: .normal)
            isrember = true
        }
        
    }
    func validateTextFields() -> Bool {
       
           emialOrPhoneTxt.customValidationRules = [RequiredRule()]
           passwordTxt.customValidationRules = [RequiredRule()]
           let validator = Validation(textFields: [emialOrPhoneTxt,passwordTxt])
           return validator.success
       }
    func makelogin() {
        parameters["emailOrPhone"] = emialOrPhoneTxt.text
        parameters["password"] = passwordTxt.text
        viewModel?.loginapi(paramters:parameters, remember: isrember)
    }
    

   
}
