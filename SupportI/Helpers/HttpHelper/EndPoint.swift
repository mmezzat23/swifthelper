//
//  EndPoint.swift
//  SupportI
//
//  Created by Mohamed Abdu on 3/20/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation

public enum EndPoint: String {
    case token = "0/connect/token"
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
    case city = "1/api/app/city/cities"
    case address = "1/api/app/address"
    case profile = "1/api/app/my-profile"
    case editprofile = "1/api/app/my-profile/edit"
    case help = "1/api/app/help"
    case socialabout = "1/api/app/help/social-links"
    case faqs = "1/api/app/help/faqs"
    case settings = "1/api/app/account-setting"
    case settingsedit = "1/api/app/account-setting/edit"
    case buyerassaller = "1/api/app/account-setting/set-buyer-as-seller"
    case deleteaccount = "1/api/app/account-setting/send-on-time-password"
    case deleteaccountdelete = "1/api/app/account-setting/confirm-delete"
    case verfiysetting = "1/api/app/account-setting/send-verify-phone-code"
    case confirmverfiy = "1/api/app/account-setting/confirm-verify-phone-code"
    case reasons = "1/api/app/contact-us/reason-list"
    case contactus = "1/api/app/contact-us"
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
    case notifications
    case banks
    case search = "ads/search"
}
