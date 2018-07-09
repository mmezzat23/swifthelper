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
    func showAlert(message:String)
    func showAlert(message:String,indetifier:UIViewController)
    func showAlert(message:String,indetifier:String)
    func showAlert(message:String,back:Bool)
    func pushViewController(indetifier:String,storyboard: String)-> UIViewController
    func push(_ view:UIViewController ,_ animated:Bool)
    
    func SnackBar(message:String,duration:TTGSnackbarDuration)
    func SnackBar(message:String,duration:TTGSnackbarDuration,dismissClosure:@escaping ()->())
    func SnackBar(message:String,duration:TTGSnackbarDuration,actionClosure:@escaping ()->())
    func SnackBar(message:String,duration:TTGSnackbarDuration,indetifier:UIViewController)
}

// implementation of PresentingViewProtocol only in cases where the presenting view is a UIViewController
extension PresentingViewProtocol where Self:UIViewController {
  
    func bind(){
        
    }
    func startLoading(){
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopLoading(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    func SnackBar(message:String,duration:TTGSnackbarDuration = .middle){
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
    func SnackBar(message:String,duration:TTGSnackbarDuration = .middle , dismissClosure:@escaping ()->()){
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
    func SnackBar(message:String,duration:TTGSnackbarDuration = .middle,actionClosure:@escaping ()->()){
        let snackbar = TTGSnackbar(message:message,
                                   duration: .forever,
                                   actionText: translate("ok"),
                                   actionBlock: { (snackbar) in
                                    actionClosure()
                                    snackbar.dismiss()
        })
        snackbar.show()
    }
    func SnackBar(message:String,duration:TTGSnackbarDuration = .middle,indetifier:UIViewController){
        let snackbar = TTGSnackbar(message:message,
                                   duration: .forever,
                                   actionText: translate("ok"),
                                   actionBlock: { (snackbar) in
                                    // Dismiss manually after 3 seconds
                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                                        snackbar.dismiss()
                                        self.push(indetifier, true)
                                    }
        })
        snackbar.show()
    }
    func showAlert(message:String)  {
        let alert = UIAlertController(title: translate("alert"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
        }
        alert.addAction(acceptAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message:String,indetifier:String)  {
        
        let alert = UIAlertController(title: translate("alert"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        if(indetifier.isEmpty){
            
            let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
            }
            alert.addAction(acceptAction)
        }else{
            let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
                
                let vc = self.pushViewController(indetifier: indetifier, storyboard: Constants.storyboard)
                self.push(vc ,true)
            }
            alert.addAction(acceptAction)
        }

    }
    func showAlert(message:String,indetifier:UIViewController)  {
        
        let alert = UIAlertController(title: translate("alert"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
            self.push(indetifier ,true)
        }
        alert.addAction(acceptAction)
    }
    func showAlert(message:String,back:Bool)  {
        
        let alert = UIAlertController(title: translate("alert"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        if !back{
            
            let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
            }
            alert.addAction(acceptAction)
        }else{
            let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
                self.navigationController?.popViewController()
            }
            alert.addAction(acceptAction)
        }

    }
    
    
}
