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
    
    func login(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connection(.login, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.token != nil)
            {
                UserRoot.save(response: response)
                let userdata = UserRoot.fetch()
                self.userdata.value = userdata

            }
            else {
//                self.userData.value = data
            }
        }
    }

}
