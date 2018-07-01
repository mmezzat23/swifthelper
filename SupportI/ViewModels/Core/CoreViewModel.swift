//
//  CoreViewModel.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation
extension PresentingViewProtocol{
    func bind(){
        
    }
}
fileprivate var presentingClass:PresentingViewProtocol?

extension ViewModelProtocol{
    var delegate:PresentingViewProtocol?{
        set{
            presentingClass = newValue
        }get{
            let vc = UIApplication.topViewController()
            if vc is PresentingViewProtocol{
                presentingClass = vc as? PresentingViewProtocol
            }
            return presentingClass
        }
    }
    
    func paginator(respnod:Array<Any>?){
        ApiManager.instance.checkPaginator(respond: respnod)
    }
    func runPaginator()->Bool{
        if !ApiManager.instance.running && !ApiManager.instance.paginatorStop{
            ApiManager.instance.incresePaginate()
            return true
        }else{
            return false
        }
    }
}


