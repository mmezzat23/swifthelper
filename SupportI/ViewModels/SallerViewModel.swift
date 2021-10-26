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
    var lookupdata: DynamicType = DynamicType<LockupModel>()
    var sizedata: DynamicType = DynamicType<SizeModel>()
    var puplishdata: DynamicType = DynamicType<UserRoot>()
    var productdetailsdata: DynamicType = DynamicType<ProductdetailModel>()
    var productssdata: DynamicType = DynamicType<ProductsModel>()
    var vediosdata: DynamicType = DynamicType<VediosModel>()

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
    func getcolors(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.color.rawValue)\(id)", type: .get) { (response) in
            let data = try? JSONDecoder().decode(SectionModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.sectiondata.value = data
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getcolors(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getlokup(id : Int) {
        delegate?.startLoading()
        print("\(EndPoint.lookup.rawValue)\(id)")
        ApiManager.instance.connection("\(EndPoint.lookup.rawValue)\(id)", type: .get) { (response) in
            let data = try? JSONDecoder().decode(LockupModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.lookupdata.value = data
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getlokup(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getsizes(id : Int) {
        delegate?.startLoading()
        ApiManager.instance.paramaters["SubCategoryId"] = id
        ApiManager.instance.connection(.size, type: .get) { (response) in
            let data = try? JSONDecoder().decode(SizeModel.self, from: response ?? Data())
            self.sizedata.value = data
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
    func addscreen1(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addproductscreen1, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.addscreen1(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func addscreen2(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addproductscreen2, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.addscreen2(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func addscreen3(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addproductscreen3, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.addscreen3(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func addscreen4(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addproductscreen4, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.addscreen4(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func addscreen5(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addproductscreen5, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.addscreen5(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func puplishproducr(id: String ) {
        delegate?.startLoading()
        ApiManager.instance.connection("\(EndPoint.addproductpuplish.rawValue)?ProductId=\(id)", type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.puplishdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.puplishproducr(id: id)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getproductdetails(paramters: [String: Any]  ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connection(.product, type: .get) { (response) in
            let data = try? JSONDecoder().decode(ProductdetailModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.productdetailsdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getproductdetails(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getproducts() {
        delegate?.startLoading()
        ApiManager.instance.connection(.vedioproduct, type: .get) { (response) in
            let data = try? JSONDecoder().decode(ProductsModel.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.productssdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getproducts()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func addvedio(paramters: [String: Any] ) {
        delegate?.startLoading()
        ApiManager.instance.paramaters = paramters
        ApiManager.instance.connectionRaw(.addvedio, type: .post) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true)
            {
                self.userdata.value = data
            }
            else {
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.addvedio(paramters: paramters)
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getsalleroffers() {
        delegate?.startLoading()
        ApiManager.instance.connection(.offers, type: .get) { (response) in
            let data = try? JSONDecoder().decode(ProductsModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.productssdata.value = data
                self.paginator(respnod: data?.responseData ?? [])
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getsalleroffers()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getsallerproducts() {
        delegate?.startLoading()
        ApiManager.instance.connection(.products, type: .get) { (response) in
            let data = try? JSONDecoder().decode(ProductsModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.productssdata.value = data
                self.paginator(respnod: data?.responseData ?? [])
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getsallerproducts()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getsallervedios() {
        delegate?.startLoading()
        ApiManager.instance.connection(.vedios, type: .get) { (response) in
            let data = try? JSONDecoder().decode(VediosModel.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.vediosdata.value = data
                self.paginator(respnod: data?.responseData?.items ?? [])
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getsallervedios()
                        }else{
                            
                        }
                    }
                }else {
                self.errordata.value = data?.errorMessage
                }
            }
        }
    }
    func getcount() {
        delegate?.startLoading()
        ApiManager.instance.connection(.countstore, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true){
            self.userdata.value = data
            }else{
                if (data?.statusCode == 401){
                    Authorization.instance.refreshToken1{callback in
                        if (callback){
                            self.getcount()
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
