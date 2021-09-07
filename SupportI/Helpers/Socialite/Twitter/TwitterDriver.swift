////
////  TwitterDriver.swift
////  RedBricks
////
////  Created by Mohamed Abdu on 6/10/18.
////  Copyright © 2018 Atiaf. All rights reserved.
////
//
//import Foundation
//import TwitterKit
//
//typealias callbackTwitter = (TwitterModel)->()
//
//class TwitterDriver:SocialError{
//    private var _closure:callbackTwitter?
//    var closure:callbackTwitter?{
//        set{
//            _closure = newValue
//            twitterLogin()
//        }get{
//            return _closure
//        }
//    }
//    
//    func twitterLogin(){
//        // Log in, and then check again
//        TWTRTwitter.sharedInstance().logIn { session, error in
//            if session != nil { // Log in succeeded
//                let model = TwitterModel(twitter: session!)
//                self.closure?(model)
//            } else {
//                //show error
//                self.alertError()
//            }
//        }
//    }
//}
//
//
