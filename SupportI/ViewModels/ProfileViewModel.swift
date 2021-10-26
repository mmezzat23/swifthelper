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
    var socialdata: DynamicType = DynamicType<UserRoot>()
    var errordata: DynamicType = DynamicType<String>()
    var resendforget: DynamicType = DynamicType<UserRoot>()
    var cardsData: DynamicType = DynamicType<Cards>()
    var deletedata: DynamicType = DynamicType<Deletecards>()
    var cityData: DynamicType = DynamicType<CityModel>()
    var addressData: DynamicType = DynamicType<AddressModel>()
    var singleaddressData: DynamicType = DynamicType<SingleaddressModel>()
    var faqsData: DynamicType = DynamicType<FaqsModel>()
    var editdata: DynamicType = DynamicType<UserRoot>()
    var deleteaccount: DynamicType = DynamicType<DeleteaccountModel>()
    var verifyphone: DynamicType = DynamicType<DeleteaccountModel>()
    var reasons: DynamicType = DynamicType<ReasonsModel>()

    func addcard(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addcard, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.addcard(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    
    func editcard(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addcard, type: .put) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.editcard(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func deletecard(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.addcard.rawValue)/\(id)", type: .delete) { (response) in
            let data = try? JSONDecoder().decode(Deletecards.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deletedata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.deletecard(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getcards() {
        delegate?.startLoading()
        ApiManager.instance.connection(.addcard, type: .get) { (response) in
            let data = try? JSONDecoder().decode(Cards.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.cardsData.value = data
                self.paginator(respnod: data?.responseData?.credits?.items)
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getcards()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getcity() {
        delegate?.startLoading()
        ApiManager.instance.connection(.city, type: .get) { (response) in
            let data = try? JSONDecoder().decode(CityModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.cityData.value = data
            self.paginator(respnod: data?.responseData?.items)
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getcity()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func addaddress(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.address, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.addaddress(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    
    func getaddresss() {
        delegate?.startLoading()
        ApiManager.instance.connection(.address, type: .get) { (response) in
            let data = try? JSONDecoder().decode(AddressModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.addressData.value = data
            self.paginator(respnod: data?.responseData?.items)
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getaddresss()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func deleteaddress(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.address.rawValue)/\(id)", type: .delete) { (response) in
            let data = try? JSONDecoder().decode(Deletecards.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deletedata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.deleteaddress(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func deletevedio(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.addvedio.rawValue)/\(id)", type: .delete) { (response) in
            let data = try? JSONDecoder().decode(Deletecards.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deletedata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.deleteaddress(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func deleteproduct(id : String) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.product.rawValue)/\(id)", type: .delete) { (response) in
            let data = try? JSONDecoder().decode(Deletecards.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deletedata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.deleteproduct(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getsingleaddress(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.address.rawValue)/\(id)", type: .get) { (response) in
            let data = try? JSONDecoder().decode(SingleaddressModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.singleaddressData.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getsingleaddress(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func editaddress(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.address, type: .put) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.editaddress(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getinfo(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connection(.help, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getinfo(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getsocial() {
        delegate?.startLoading()
        ApiManager.instance.connection(.socialabout, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.socialdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getsocial()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getcontact() {
        delegate?.startLoading()
        ApiManager.instance.connection(.customerservice, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.socialdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getcontact()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getfaqs(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connection(.faqs, type: .get) { (response) in
            let data = try? JSONDecoder().decode(FaqsModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.faqsData.value = data
            self.paginator(respnod: data?.responseData?.items)
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getfaqs(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getaccountsetting() {
        delegate?.startLoading()
        ApiManager.instance.connection(.settings, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getaccountsetting()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func editaccountsetting(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.settingsedit, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.editdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.editaccountsetting(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func editpasswodr(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.passwordsedit, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.editdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.editpasswodr(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func verfiyaccountsetting(phone : String ) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.verfiysetting.rawValue)?phone=\(phone)", type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(DeleteaccountModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.verifyphone.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.verfiyaccountsetting(phone: phone)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func confirmaccountsetting(code : String ) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.confirmverfiy.rawValue)?code=\(code)", type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(DeleteaccountModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.verifyphone.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.confirmaccountsetting(code: code)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func verfiyemailaccountsetting(phone : String ) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.verfiysettingemail.rawValue)?email=\(phone)", type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(DeleteaccountModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.verifyphone.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.verfiyemailaccountsetting(phone: phone)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func confirmaccountsettingemail(code : String ) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.confirmverfiyemail.rawValue)?code=\(code)", type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(DeleteaccountModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.verifyphone.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.confirmaccountsettingemail(code: code)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func changetosaller() {
        delegate?.startLoading()
        ApiManager.instance.connection(.buyerassaller, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.editdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.changetosaller()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func deleteaccountapi(reason: String) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.deleteaccount.rawValue)?reason=\(reason)", type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(DeleteaccountModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deleteaccount.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.deleteaccountapi(reason: reason)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func deleteaccountconfirm(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.deleteaccountdelete, type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(Deletecards.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deletedata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.deleteaccountconfirm(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getreasons(type : String) {
        delegate?.startLoading()
        ApiManager.instance.paramaters["reasonType"] = type
        ApiManager.instance.connection(.reasons, type: .get) { (response) in
            let data = try? JSONDecoder().decode(ReasonsModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.reasons.value = data
                self.paginator(respnod: data?.responseData)
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getreasons(type: type)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func contactus(paramters: [String: Any]) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.contactus, type: .post) { (response) in
            let data = try? JSONDecoder().decode(Deletecards.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.deletedata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.contactus(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func editpayment(type: String ) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.paymentdefualt.rawValue)?paymentMethod=\(type)", type: .post) { (response) in
            self.delegate?.stopLoading()
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.editdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.editpayment(type: type)
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
