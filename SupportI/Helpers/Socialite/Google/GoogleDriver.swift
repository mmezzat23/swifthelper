//////
//////  GoogleProvider.swift
//////  RedBricks
//////
//////  Created by Mohamed Abdu on 6/11/18.
//////  Copyright © 2018 Atiaf. All rights reserved.
//////
//
//import Foundation
//import GoogleSignIn
//
//typealias CallbackGoogle = (GoogleModel) -> Void
//private var closurePrivate: CallbackGoogle?
//
//class GoogleDriver:UIViewController, GoogleProviderDelegate, SocialIndicator {
//    var closure: CallbackGoogle? {
//        set {
//            closurePrivate = newValue
//        } get {
//            return closurePrivate
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initView()
//    }
//    func initView(){
//        self.view.backgroundColor = UIColor.white
//    }
//    func googleProvider() {
//        let topVC = UIApplication.topViewController()
//        topVC?.present(self, animated: false, completion: {
//            GIDSignIn.sharedInstance().presentingViewController = self
//            GIDSignIn.sharedInstance().clientID = SocialConstant.googleId
//            GIDSignIn.sharedInstance().delegate = self
//            GIDSignIn.sharedInstance().signIn()
//        })
//        
//    }
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print("\(error.localizedDescription)")
//            self.dismiss(animated: false) {
//                self.stopLoading()
//            }
//        } else {
//            self.dismiss(animated: false) {
//                // Perform any operations on signed in user here.
//                let model = GoogleModel(user: user)
//                self.closure?(model)
//                self.stopLoading()
//                // ...
//            }
//           
//        }
//    }
//    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
//        stopLoading()
//        //myActivityIndicator.stopAnimating()
//    }
//    
//    // Present a view that prompts the user to sign in with Google
//    func sign(_ signIn: GIDSignIn!,
//              present viewController: UIViewController!) {
//        self.present(viewController, animated: true, completion: nil)
//    }
//    
//    // Dismiss the "Sign in with Google" view
//    func sign(_ signIn: GIDSignIn!,
//              dismiss viewController: UIViewController!) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
