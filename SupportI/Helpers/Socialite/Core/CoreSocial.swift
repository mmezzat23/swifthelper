//
//  CoreSocial.swift
//  RedBricks
//
//  Created by Mohamed Abdu on 6/11/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

enum Socials: Int {
    case facebook = 1
    case twitter = 2
    case google = 3
    case instagram = 4
}
class SocialModel {
    var type: Socials?
    init(type: Socials) {
        self.type = type
    }
}

protocol SocialIndicator {
    func startLoading()
    func stopLoading()
}
extension SocialIndicator {

    func startLoading() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    func stopLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
