//
//  SallerViewModel.swift
//  Wndo
//
//  Created by Adam on 18/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

class SallerViewModel: ViewModelCore {
    var userdata: DynamicType = DynamicType<UserRoot>()
    var errordata: DynamicType = DynamicType<String>()
    
    func isactivesaller( ) {
        delegate?.startLoading()
        ApiManager.instance.connection(.activesaller, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.isactivesaller()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
}
