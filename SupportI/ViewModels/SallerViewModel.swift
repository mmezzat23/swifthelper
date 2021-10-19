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
    var sectiondata: DynamicType = DynamicType<SectionModel>()
    var catdata: DynamicType = DynamicType<SectionModel>()
    var subcatdata: DynamicType = DynamicType<SectionModel>()

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
    func getsection() {
        delegate?.startLoading()
        ApiManager.instance.connection(.section, type: .get) { (response) in
            let data = try? JSONDecoder().decode(SectionModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.sectiondata.value = data
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getsection()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getcats(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.paramaters["section"] = id
        ApiManager.instance.connection(.catogary, type: .get) { (response) in
            let data = try? JSONDecoder().decode(SectionModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.catdata.value = data
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getcats(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getsubcats(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.paramaters["category"] = id
        ApiManager.instance.connection(.subcat, type: .get) { (response) in
            let data = try? JSONDecoder().decode(SectionModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.subcatdata.value = data
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getsubcats(id: id)
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
