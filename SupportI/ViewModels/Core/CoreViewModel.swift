//
//  CoreViewModel.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation

class ViewModelCore:ViewModelProtocol {
    
    weak var _delegate:PresentingViewProtocol?
    weak var delegate:PresentingViewProtocol?{
        set{
            _delegate = newValue
        }get{
            return _delegate
        }
    }
    deinit {
        print("deinit")
    }
    
}
