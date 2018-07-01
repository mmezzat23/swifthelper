//
//  UIConstraintLayout.swift
//  RedBricks
//
//  Created by Mohamed Abdu on 6/3/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

extension NSLayoutConstraint{
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
    
    func checkMultiplayer()->NSLayoutConstraint{
        if getAppLang() == "ar"{
            if self.multiplier < 1{
                let newMulti = 1+(1 - self.multiplier)
                return self.setMultiplier(multiplier: newMulti)
                
            }
            if self.multiplier > 1{
                let newMulti = 1 - (self.multiplier - 1)
                return self.setMultiplier(multiplier: newMulti)
            }else{
                return self.setMultiplier(multiplier: 1)
            }
        }else{
            return self.setMultiplier(multiplier: 1)
        }
        
        
    }
}
