//
//  CorePresentingViewModel.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

// All ViewControllers must implement this protocol
protocol PresentingViewProtocol: class {

    func bind()
    func startLoading()
    func stopLoading()
    func push(_ view: UIViewController, _ animated: Bool)
    func snackBar(message: String, duration: TTGSnackbarDuration)
    func snackBar(message: String, duration: TTGSnackbarDuration, dismissClosure:@escaping () -> Void)
    func snackBar(message: String, duration: TTGSnackbarDuration, actionClosure:@escaping () -> Void)
}

// implementation of PresentingViewProtocol only in cases where the presenting view is a UIViewController
extension PresentingViewProtocol where Self: UIViewController {
    func bind() {

    }
    func snackBar(message: String, duration: TTGSnackbarDuration = .middle) {
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
    func snackBar(message: String, duration: TTGSnackbarDuration = .middle, dismissClosure:@escaping () -> Void) {
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
    func snackBar(message: String, duration: TTGSnackbarDuration = .middle, actionClosure:@escaping () -> Void) {
        let snackbar = TTGSnackbar(message: message,
                                   duration: .forever,
                                   actionText: "sure.lan".localized,
                                   actionBlock: { (snackbar) in
                                    actionClosure()
                                    snackbar.dismiss()
        })
        snackbar.show()
    }
}
