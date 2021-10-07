//
//  Login.swift
//  SupportI
//
//  Created by Adam on 9/9/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import AuthenticationServices
import GoogleSignIn
class LoginController: BaseController {
    
    @IBOutlet weak var appleview: UIButton!
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
        if #available(iOS 13.0, *) {
                    setUpSignInAppleButton()
                } else {
                    // Fallback on earlier versions
                }
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
    
    @IBAction func skip(_ sender: Any) {
        guard let scene = UIStoryboard(name: Storyboards.main.rawValue, bundle: nil).instantiateInitialViewController() else { return }
        self.push(scene)
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
        let signInConfig = GIDConfiguration.init(clientID: SocialConstant.googleId)
             GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
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
                                viewModel?.loginapi(paramters:parameters, remember: isrember)
                               
                            }
                
             }
//        let driver = GoogleDriver()
//        driver.closure = { user in
//            self.startLoading()
//
//        }
//        driver.googleProvider()
    }
    
    @IBAction func loginWithFacebookClicked(_ sender: UIButton) {
        let driver = FacebookDriver(delegate: self)
        driver.callback { user in
            self.startLoading()
            ApiManager.instance.paramaters["providerId"] = user.id
            ApiManager.instance.paramaters["providerName"] = "facebook"
            ApiManager.instance.paramaters["email"] = user.email
            ApiManager.instance.connectionRaw(.socaillogin, type: .post) { [self] (response) in
                self.stopLoading()
                let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                parameters["emailOrPhone"] = data?.responseData?.userName
                parameters["password"] = data?.responseData?.password
                viewModel?.loginapi(paramters:parameters, remember: isrember)
            }
        }
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
extension LoginController: ASAuthorizationControllerDelegate {
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
                    viewModel?.loginapi(paramters:parameters, remember: isrember)
                }
                           
            }
        }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        }

    }
