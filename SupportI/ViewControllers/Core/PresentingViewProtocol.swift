//
//  CorePresentingViewModel.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

// All ViewControllers must implement this protocol
protocol PresentingViewProtocol :class{
    
    func bind()
    func startLoading()
    func stopLoading()
    func push(_ view:UIViewController ,_ animated:Bool)
    
    func snackBar(message:String,duration:TTGSnackbarDuration)
    func snackBar(message:String,duration:TTGSnackbarDuration,dismissClosure:@escaping ()->())
    func snackBar(message:String,duration:TTGSnackbarDuration,actionClosure:@escaping ()->())
}

// implementation of PresentingViewProtocol only in cases where the presenting view is a UIViewController
extension PresentingViewProtocol where Self:UIViewController {
    func randomIndicatorView(){
        // pick and return a new value
        var rand = random(32)
        if rand == 31 || rand == 25 || rand == 19 || rand == 20 || rand == 14 || rand == 15 || rand == 4 || rand == 26 {
            rand = 29
        }
        let type = NVActivityIndicatorType(rawValue: rand)
        guard let loading = type else { return }
        NVActivityIndicatorView.DEFAULT_TYPE = loading
    }
    func bind(){
        
    }
    func startLoading(){
        self.randomIndicatorView()
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopLoading(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    func snackBar(message:String,duration:TTGSnackbarDuration = .middle) {
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.onSwipeBlock = { (snackbar, direction) in
            // Change the animation type to simulate being dismissed in that direction
            if direction == .right {
                snackbar.animationType = .slideFromLeftToRight
            } else if direction == .left {
                snackbar.animationType = .slideFromRightToLeft
            } else if direction == .up {
                snackbar.animationType = .slideFromTopBackToTop
            } else if direction == .down {
                snackbar.animationType = .slideFromTopBackToTop
            }
            
            snackbar.dismiss()
        }
        snackbar.show()
        
    }
    func snackBar(message:String,duration:TTGSnackbarDuration = .middle , dismissClosure:@escaping ()->()){
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.onSwipeBlock = { (snackbar, direction) in
            
            // Change the animation type to simulate being dismissed in that direction
            if direction == .right {
                snackbar.animationType = .slideFromLeftToRight
            } else if direction == .left {
                snackbar.animationType = .slideFromRightToLeft
            } else if direction == .up {
                snackbar.animationType = .slideFromTopBackToTop
            } else if direction == .down {
                snackbar.animationType = .slideFromTopBackToTop
            }
            
            snackbar.dismiss()
        }
        snackbar.dismissBlock = {
            (snackbar) in dismissClosure()
        }
        snackbar.show()
        
        
    }
    func snackBar(message:String,duration:TTGSnackbarDuration = .middle,actionClosure:@escaping ()->()){
        let snackbar = TTGSnackbar(message:message,
                                   duration: .forever,
                                   actionText: translate("ok"),
                                   actionBlock: { (snackbar) in
                                    actionClosure()
                                    snackbar.dismiss()
        })
        snackbar.show()
    }
}
