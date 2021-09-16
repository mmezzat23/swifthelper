//
//  Auth1ViewModel.swift
//  SupportI
//
//  Created by Kareem on 9/14/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation
class Auth1ViewModel: ViewModelCore {
    
    var userdata: DynamicType = DynamicType<UserRoot>()
    var errordata: DynamicType = DynamicType<String>()
    var resenddata: DynamicType = DynamicType<Bool>()

    func RegisterApi(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.registerUrl, type: .post) { (response) in
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
    
    func VerifyOtpApi(paramters: [String: Any] , url : EndPoint ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(url, type: .post) { (response) in
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
    func resendApi(username:String  ) {
        delegate?.startLoading()
        ApiManager.instance.connectionRaw("\(EndPoint.resend.rawValue)?userName=\(username)", type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.resenddata.value = true
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }


}
