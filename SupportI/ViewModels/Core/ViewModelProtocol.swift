//
//  ViewModelProtocol.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation


// All ViewModels must implement this protocol
protocol ViewModelProtocol {
    var delegate: PresentingViewProtocol? { set get }
    func paginator(respnod: Array<Any>?)
    func runPaginator() -> Bool
    func resetPaginator()
    
}


extension ViewModelProtocol {
    
    func paginator(respnod: Array<Any>?) {
        ApiManager.instance.checkPaginator(respond: respnod)
    }
    func runPaginator() ->Bool {
        if !ApiManager.instance.running && !ApiManager.instance.paginatorStop{
            ApiManager.instance.incresePaginate()
            return true
        }else{
            return false
        }
    }
    func resetPaginator() {
        ApiManager.instance.resetPaginate()
    }
}



