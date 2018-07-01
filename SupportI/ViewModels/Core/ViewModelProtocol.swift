//
//  ViewModelProtocol.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation

// All ViewModels must implement this protocol
protocol ViewModelProtocol: class {
    func paginator(respnod:Array<Any>?)
    func runPaginator()->Bool
}
