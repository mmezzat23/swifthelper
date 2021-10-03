//
//  viewshadow.swift
//  SupportI
//
//  Created by Adam on 10/3/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

@IBDesignable
class viewshadow: UIView {
    
    @IBInspectable var firstcolor : UIColor = UIColor.clear{
        didSet {
            updateview()
        }
    }
    @IBInspectable var secondcolor : UIColor = UIColor.clear{
        didSet {
            updateview()
        }
    }
    
    override class var layerClass : AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateview(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstcolor.cgColor , secondcolor.cgColor]
    }
    
}
