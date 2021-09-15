//
//  AuthViewModel.swift
//  SupportI
//
//  Created by Adam on 9/9/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

class AuthViewModel: ViewModelCore {
    var userdata: DynamicType = DynamicType<UserRoot>()
    var errordata: DynamicType = DynamicType<String>()
    var resendforget: DynamicType = DynamicType<UserRoot>()

    func loginapi(paramters: [String: Any] , remember : Bool) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.loginurl, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                UserRoot.save(response: response , remember: remember)
                let userdata = UserRoot.fetch()
                self.userdata.value = userdata
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }
    func forgetapi(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.forget, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }
    func resendgorget(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.forget, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.resendforget.value = data
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }
    func verifyforgetapi(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.verifyForgetPasswordOTP, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }
    func resetapi(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.reset, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }
}
