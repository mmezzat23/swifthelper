//
//  ApiProtocol.swift
//  Tafran2
//
//  Created by mohamed abdo on 5/19/18.
//  Copyright © 2018 AtiafApps. All rights reserved.
//
import Alamofire

protocol Api {
    func callGet(_ method:Apis ,_ completionHandler: @escaping (Data?) -> ())
    func callPost(_ method:Apis ,_ completionHandler: @escaping (Data?) -> ())
    func callPut(_ method:Apis ,_ completionHandler: @escaping (Data?) -> ())
    func callDelete(_ method:Apis ,_ completionHandler: @escaping (Data?) -> ())
}





