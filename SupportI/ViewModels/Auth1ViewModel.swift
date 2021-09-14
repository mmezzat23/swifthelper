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
    
    func RegisterApi(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connection(.register, type: .post) { (response) in
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
