//
//  Initial.swift
//  SupportI
//
//  Created by Mohamed Abdu on 3/20/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import MBProgressHUD

var showLoadingMainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
var animationView = AnimationView()
let animation = Animation.named("loading" )

extension UIViewController: MBProgressHUDDelegate {
    func successProgress() {
        let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
        progress.mode = .annularDeterminate
        progress.isUserInteractionEnabled = false
        progress.show(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.hideSuccessProgress()
        }
    }
    func hideSuccessProgress() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    func startLoading() {
        DispatchQueue.main.async {
            if self.view.subviews.contains(showLoadingMainView) {
                return
            }
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
            self.tabBarController?.tabBar.isUserInteractionEnabled = false
            self.view.isUserInteractionEnabled = false
            showLoadingMainView = UIView(frame: CGRect(x: self.view.width / 2 + 25, y: self.view.height / 2 + 25, width: 50, height: 50))
            showLoadingMainView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            self.view.addSubview(showLoadingMainView)
            showLoadingMainView.addSubview(animationView)
            showLoadingMainView.translatesAutoresizingMaskIntoConstraints = false
            showLoadingMainView.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
            showLoadingMainView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            showLoadingMainView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
            showLoadingMainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
            animationView.translatesAutoresizingMaskIntoConstraints = false
            animationView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
            animationView.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true
            animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            animationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
            animationView.animation = animation
            // Setup our animaiton view
            animationView.contentMode = .scaleAspectFit
            // Lets turn looping on, since we want it to repeat while the image is 'Downloading'
            animationView.loopMode = .loop
            // Now play from 0 to 0.5 progress and loop indefinitely.
            animationView.play(fromProgress: 0, toProgress: 1, completion: nil)
        }
    }
    func stopLoading() {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
            self.view.isUserInteractionEnabled = true
            showLoadingMainView.removeFromSuperview()
        }
    }
}
