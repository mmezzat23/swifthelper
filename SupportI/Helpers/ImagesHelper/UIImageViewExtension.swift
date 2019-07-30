//
//  UIImageViewExtension.swift
//  RedBricks
//
//  Created by mohamed abdo on 6/4/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit
import AlamofireImage

fileprivate var staticalyTranstion:UIImageView.ImageTransition? = nil
fileprivate var isLoadedPrivate:[UIImageView:Bool] = [:]
extension UIImageView{
    var isLoaded:Bool {
        set{
            isLoadedPrivate[self] = newValue
        }get{
            if isLoadedPrivate[self] != nil {
                return true
            }else{
                return false
            }
        }
    }
    var imageTranstion:ImageTransition?{
        get{
            if staticalyTranstion == nil {
                staticalyTranstion = UIImageView.randomTransiation()
                return staticalyTranstion
            }else{
                return staticalyTranstion
            }
        }
        set{
            staticalyTranstion = nil
        }
    }
    //Random direction.
    static func randomTransiation() -> ImageTransition? {
        var index = Int(arc4random_uniform(7))
        switch index {
        case 0:
            index = 1
            return ImageTransition.crossDissolve(0.40)
        case 1:
            return ImageTransition.crossDissolve(0.40)
        case 2:
            return ImageTransition.curlDown(0.40)
        case 3:
            return ImageTransition.curlUp(0.40)
        case 4:
            return ImageTransition.flipFromBottom(0.40)
        case 5:
            return ImageTransition.flipFromLeft(0.40)
        case 6:
            return ImageTransition.flipFromRight(0.40)
        case 7:
            return ImageTransition.flipFromTop(0.40)
            
        default:
            return nil
        }
    }
    
    func setImage(url: String?,animate:Bool = false){
        guard let string = url else {return}
        let Url = URL(string: string)
        
        guard let finalUrl = Url else{ return }
        
        if animate {
            guard let transation = self.imageTranstion else {return}
            self.af_setImage(withURL: finalUrl, placeholderImage: Constants.placeHolderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: transation, runImageTransitionIfCached: true, completion: { _ in
                self.isLoaded = true
            })
            
            
        }else{
            self.af_setImage(withURL: finalUrl, placeholderImage:  Constants.placeHolderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: true, completion: { _ in
                self.isLoaded = true
            })
        }
        
    }
}

