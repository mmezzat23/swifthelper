////
////  TwitterDelegate.swift
////  RedBricks
////
////  Created by Mohamed Abdu on 6/11/18.
////  Copyright © 2018 Atiaf. All rights reserved.
////
//
//import Foundation
//import TwitterKit
//
//extension AppDelegate{
//    func application(_ application: UIApplication,open url: URL,options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
//        //let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options)
//        //return handled
//        //        return GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,annotation: [:])
//        return TWTRTwitter.sharedInstance().application(application, open: url, options: options)
//        
//    }
//    // twitter
//    func initTwitter(){
//        TWTRTwitter.sharedInstance().start(withConsumerKey: SocialConstant.twitterId, consumerSecret: SocialConstant.twitterKey)
//    }
//    //
//}
