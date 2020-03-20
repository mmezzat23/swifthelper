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
    var delegate: PresentingViewProtocol? { get set }
    func paginator(respnod: [Any]?)
    func runPaginator() -> Bool
    func resetPaginator()

}

extension ViewModelProtocol {

    func paginator(respnod: [Any]?) {
        ApiManager.instance.checkPaginator(respond: respnod)
    }
    func runPaginator() -> Bool {
        if !ApiManager.instance.isHttpRequestRun && !ApiManager.instance.paginatorStop {
            ApiManager.instance.incresePaginate()
            return true
        } else {
            return false
        }
    }
    func resetPaginator() {
        ApiManager.instance.resetPaginate()
    }
}
