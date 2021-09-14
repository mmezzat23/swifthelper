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
}
