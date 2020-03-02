//
//  UIColorExtensions.swift
//  homeCheif
//
//  Created by Mohamed Abdu on 4/17/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

extension UIColor {
    static func colorRGB(red:Int,green:Int,blue:Int,alpha:Float = 1) -> UIColor {
        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
    }
}
