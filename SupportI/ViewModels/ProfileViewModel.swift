//
//  ProfileViewModel.swift
//  SupportI
//
//  Created by Adam on 9/26/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

class ProfileViewModel: ViewModelCore {
    var userdata: DynamicType = DynamicType<UserRoot>()
    var errordata: DynamicType = DynamicType<String>()
    var resendforget: DynamicType = DynamicType<UserRoot>()
    var cardsData: DynamicType = DynamicType<Cards>()
    var deletedata: DynamicType = DynamicType<Deletecards>()
    var cityData: DynamicType = DynamicType<CityModel>()
    var addressData: DynamicType = DynamicType<AddressModel>()
    var singleaddressData: DynamicType = DynamicType<SingleaddressModel>()

    func addcard(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addcard, type: .post) { (response) in
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
    
    func editcard(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addcard, type: .put) { (response) in
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
    func deletecard(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.addcard.rawValue)/\(id)", type: .delete) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(Deletecards.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deletedata.value = data
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }
    func getcards() {
        delegate?.startLoading()
        ApiManager.instance.connection(.addcard, type: .get) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(Cards.self, from: response ?? Data())
            self.cardsData.value = data
            self.paginator(respnod: data?.responseData?.items)
        }
    }
    func getcity() {
        delegate?.startLoading()
        ApiManager.instance.connection(.city, type: .get) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(CityModel.self, from: response ?? Data())
            self.cityData.value = data
            self.paginator(respnod: data?.responseData?.items)
        }
    }
    func addaddress(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.address, type: .post) { (response) in
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
    
    func getaddresss() {
        delegate?.startLoading()
        ApiManager.instance.connection(.address, type: .get) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(AddressModel.self, from: response ?? Data())
            self.addressData.value = data
            self.paginator(respnod: data?.responseData?.items)
        }
    }
    func deleteaddress(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.address.rawValue)/\(id)", type: .delete) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(Deletecards.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deletedata.value = data
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }
    func getsingleaddress(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.address.rawValue)/\(id)", type: .get) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(SingleaddressModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.singleaddressData.value = data
            }
            else {
                self.errordata.value = data?.errorMessage
            }
        }
    }
    func editaddress(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.address, type: .put) { (response) in
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
