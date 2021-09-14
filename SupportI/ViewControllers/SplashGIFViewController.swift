//
//  SplashGIFViewController.swift
//  SupportI
//
//  Created by Kareem on 9/13/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import SwiftyGif
class SplashGIFViewController: UIViewController {
    
    //MARK:- @IBOutlet
    @IBOutlet weak var animatedGifImage: UIImageView!
    //MARK:- Vars
    var gif : UIImage?
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animatedGifImage.delegate = self
//        if UserStatus.lang == nil {
//            UserStatus.lang = "en"
//        }
        do {
//            if UserStatus.lang == "en"  {
                gif = try UIImage(gifName: "WNDo GIF.gif")
//            } else {
//                gif = try UIImage(gifName: "PinkMerce-Logo_Arabic-Version_1000px_No-loop.gif")
//            }
            self.animatedGifImage.setGifImage(gif ?? UIImage() , loopCount: 1)
        } catch {
            print(error)
        }
        
    }
    
    //Mark:- Methods
    func goToMainScreen() {
        initLang()
        //        SVProgressHUD.dismiss()
        //        if case UserStatus.isEnterIntro = true {
        //            if case UserStatus.isLogged = true {
        //                (UIApplication.shared.delegate as! AppDelegate).reset(selectedTabbarIndex: 0)
        //            } else {
        //                RootWindowController.setRootWindowForLogin()
        //            }
        //        } else {
        //            RootWindowController.setRootInto()
        //        }
        //    }
        
    }
}

extension SplashGIFViewController : SwiftyGifDelegate {
    
    func gifURLDidFinish(sender: UIImageView) {
        print("gifURLDidFinish")
    }
    
    func gifURLDidFail(sender: UIImageView) {
        print("gifURLDidFail")
    }
    
    func gifDidStart(sender: UIImageView) {
        print("gifDidStart")
    }
    
    func gifDidLoop(sender: UIImageView) {
        print("gifDidLoop")
    }
    
    func gifDidStop(sender: UIImageView) {
        print("gifDidStop")
        self.goToMainScreen()
    }
}
