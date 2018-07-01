//
//  BaseViewControllerProtocol.swift
//  FashonDesign
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewControllerProtocol {
    func setup()
    func setupBase()
    func pushViewController(indetifier:String ,storyboard: String)->UIViewController
    func push(_ view:UIViewController,_ animated:Bool)
}
extension BaseViewControllerProtocol{
    func setup(){
        
    }
}
