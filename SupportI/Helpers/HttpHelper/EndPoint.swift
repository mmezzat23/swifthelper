//
//  EndPoint.swift
//  SupportI
//
//  Created by Mohamed Abdu on 3/20/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation

public enum EndPoint: String {
    case token = "connect/token"
    case update = "user/update"
    case loginurl = "1/api/app/register/login"
//    case login1 = "connect/token"
    case registerUrl = "1/api/app/register"
    case verifyRegisterationOTP = "1/api/app/register/verify-code"
    case verifyForgetPasswordOTP = "1/api/app/register/verify-code-for-forget-password"
    case forget = "1/api/app/register/forget-password"
    case reset = "1/api/app/register/reset-password"
    case resend = "1/api/app/register/re-send-new-code"
    case addcard = "1/api/app/credit-card"
    case city = "1/api/app/city"
    case address = "1/api/app/address"
    case logout
    case packages
    case locations
    case categories
    case ads
    case like
    case favorite
    case follow
    case comment
    case comments
    case report = "ads/report"
    case favorites
    case advertisers
    case settings
    case notifications
    case banks
    case search = "ads/search"
}
