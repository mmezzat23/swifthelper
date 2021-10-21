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
    case customerservice = "1/api/app/contact-us/customer-service-number"
    case faqs = "1/api/app/help/faqs"
    case settings = "1/api/app/account-setting"
    case settingsedit = "1/api/app/account-setting/edit"
    case passwordsedit = "1/api/app/account-setting/check-password"
    case buyerassaller = "1/api/app/account-setting/set-buyer-as-seller"
    case deleteaccount = "1/api/app/account-setting/send-on-time-password"
    case deleteaccountdelete = "1/api/app/account-setting/confirm-delete"
    case verfiysetting = "1/api/app/account-setting/send-verify-phone-code"
    case confirmverfiy = "1/api/app/account-setting/confirm-verify-phone-code"
    case verfiysettingemail = "1/api/app/account-setting/send-verify-email-code"
    case confirmverfiyemail = "1/api/app/account-setting/confirm-verify-email-code"
    case reasons = "1/api/app/contact-us/reason-list"
    case contactus = "1/api/app/contact-us"
    case socaillogin = "1/api/app/register/external-login"
    case paymentdefualt = "1/api/app/account-setting/set-default-payment-method"
    case activesaller = "1/api/app/product/check-is-active-seller"
    case section = "1/api/app/section/sections"
    case seginure = "1/api/app/product/signature"
    case catogary = "1/api/app/category/categories"
    case subcat = "1/api/app/sub-category/sub-categories"
    case addproductscreen1 = "1/api/app/product/screen1"
    case addproductscreen2 = "1/api/app/product/screen2"
    case addproductscreen3 = "1/api/app/product/screen3"
    case addproductscreen4 = "1/api/app/product/product-shipping"
    case addproductscreen5 = "1/api/app/product/product-price"
    case addproductpuplish = "/api/app/product/"
    case lookup = "1/api/app/lookup/by-sub-id/"
    case color = "1/api/app/color/colors/"
    case size = "1/api/app/size"
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
