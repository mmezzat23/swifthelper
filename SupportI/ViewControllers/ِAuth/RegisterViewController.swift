//
//  RegisterViewController.swift
//  SupportI
//
//  Created by Kareem on 9/13/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import AuthenticationServices
import GoogleSignIn

class RegisterViewController: BaseController {
    
    @IBOutlet weak var eye: UIImageView!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emialOrPhoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var appleview: UIButton!

    @IBOutlet weak var terms: UILabel!
    var authModel : AuthViewModel?
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
        let signInConfig = GIDConfiguration.init(clientID: SocialConstant.googleId)
             GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                 if ((user?.userID != nil)) {
                self.startLoading()
                ApiManager.instance.paramaters["providerId"] = user?.userID
                           ApiManager.instance.paramaters["providerName"] = "google"
                ApiManager.instance.paramaters["email"] = user?.profile?.email
                           print(ApiManager.instance.paramaters)
                           ApiManager.instance.connectionRaw(.socaillogin, type: .post) { [self] (response) in
                               self.stopLoading()
                               let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                               parameters["emailOrPhone"] = data?.responseData?.userName
                               parameters["password"] = data?.responseData?.password
                               authModel?.loginapi(paramters:parameters, remember: true)
                           }
             }
             }
    }
    
    @IBAction func signUpWithFacebookClicked(_ sender: UIButton) {
//        let driver = FacebookDriver(delegate: self)
//        driver.callback { user in
//            self.startLoading()
//            ApiManager.instance.paramaters["providerId"] = user.id
//            ApiManager.instance.paramaters["providerName"] = "facebook"
//            ApiManager.instance.paramaters["email"] = user.email
//            ApiManager.instance.connectionRaw(.socaillogin, type: .post) { [self] (response) in
//                self.stopLoading()
//                let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
//                parameters["emailOrPhone"] = data?.responseData?.userName
//                parameters["password"] = data?.responseData?.password
//                authModel?.loginapi(paramters:parameters, remember: true)
//            }
//        }
    }
    func validateTextFields() -> Bool {
        if !isPhoneNumber {
            emialOrPhoneTxt.customValidationRules = [RequiredRule() , EmailRule()]
        } else {
            emialOrPhoneTxt.customValidationRules = [RequiredRule() , MinLengthRule(length: 11)]
        }
        userNameTxt.customValidationRules = [RequiredRule() , MaxLengthRule(length: 16)]
        passwordTxt.customValidationRules = [RequiredRule(), MaxLengthRule(length: 8),  PasswordRule()]
        let validator = Validation(textFields: [emialOrPhoneTxt , userNameTxt ,passwordTxt])
        return validator.success
    }
    
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
       authModel = .init()
       authModel?.delegate = self
        if #available(iOS 13.0, *) {
                    setUpSignInAppleButton()
                } else {
                    // Fallback on earlier versions
                }
        terms.UIViewAction {
            let vcc = self.controller(Terms.self,storyboard: .setting)
            self.push(vcc)
        }
        eye.UIViewAction { [self] in
            if (passwordTxt.isSecureTextEntry){
                passwordTxt.isSecureTextEntry = false
                eye.image = #imageLiteral(resourceName: "eye Active")
            }else{
                passwordTxt.isSecureTextEntry = true
                eye.image = #imageLiteral(resourceName: "eye")
            }
        }
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
            let scene = self?.controller(CodeverficationController.self,storyboard: .auth1)
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
        authModel?.userdata.bind({ [weak self](data) in
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
    }
    
}

extension RegisterViewController: ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func setUpSignInAppleButton() {
        let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
        authorizationButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        (authorizationButton as UIControl).cornerRadius = 25
        (authorizationButton as UIControl).borderWidth = 0.5
        (authorizationButton as UIControl).borderColor = .clear
        authorizationButton.frame = CGRect(x: 0, y: 0, width: appleview.frame.width, height: appleview.frame.height)
        //Add button on some view or stack
        self.appleview.addSubview(authorizationButton)
    }

    @available(iOS 13.0, *)
    @objc func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }


    func checkLogin(userID: String) {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userID) {  (credentialState, error) in
                              switch credentialState {
                                 case .authorized:
                                     // The Apple ID credential is valid.
                                     break
                                 case .revoked:
                                     // The Apple ID credential is revoked.
                                     break
                              case .notFound: break
                                     // No credential was found, so show the sign-in UI.
                                 default:
                                     break
                              }
                         }
        } else {
            // Fallback on earlier versions
        }

    }
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

            if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email
               
                self.startLoading()
                ApiManager.instance.paramaters["providerId"] = userIdentifier
                ApiManager.instance.paramaters["providerName"] = "apple"
                ApiManager.instance.paramaters["email"] = email
                print(parameters)
                ApiManager.instance.connectionRaw(.socaillogin, type: .post) { [self] (response) in
                    self.stopLoading()
                    let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                    self.parameters["emailOrPhone"] = data?.responseData?.userName
                    parameters["password"] = data?.responseData?.password
                    authModel?.loginapi(paramters:parameters, remember: true)
                }
                           
            }
        }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        }

    }
