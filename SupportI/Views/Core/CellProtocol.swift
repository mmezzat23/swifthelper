//
//  UICollectionViewProtocol.swift
//
//  Created by Mohamed Abdu on 6/4/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

public enum CellError:Error {
    case confirmProtocol
}

public protocol CellProtocol {
    var model:Any? {set get}
    var path:Int? {set get}
    func setup()
    func indexPath()->Int
}
fileprivate var modelOfCollectionCell:[UICollectionViewCell:Any] = [:]
fileprivate var modelOfTableCell:[UITableViewCell:Any] = [:]
fileprivate var pathOfCollectionCell:[UICollectionViewCell:Int] = [:]
fileprivate var pathOfTableCell:[UITableViewCell:Int] = [:]

public extension CellProtocol {
    /// index path of item
    
    var path:Int?{
        set{
            guard let index = newValue else {return}
            if self is UICollectionViewCell {
                let cell = self as! UICollectionViewCell
                pathOfCollectionCell[cell] = index
            }else if self is UITableViewCell {
                let cell = self as! UITableViewCell
                pathOfTableCell[cell] = newValue
            }
        }get{
            
            if self is UICollectionViewCell {
                let cell = self as! UICollectionViewCell
                guard let index = pathOfCollectionCell[cell] else {return nil}
                return index
            }else if self is UITableViewCell {
                let cell = self as! UITableViewCell
                guard let index = pathOfTableCell[cell] else {return nil}
                return index
            }else{
                return nil
            }
        }
    }
    
    var model:Any? {
        set{
            if self is UICollectionViewCell {
                let cell = self as! UICollectionViewCell
                modelOfCollectionCell[cell] = newValue
            }else if self is UITableViewCell {
                let cell = self as! UITableViewCell
                modelOfTableCell[cell] = newValue
            }
            setup()
        }get{
            if self is UICollectionViewCell {
                let cell = self as! UICollectionViewCell
                return modelOfCollectionCell[cell]
            }else if self is UITableViewCell {
                let cell = self as! UITableViewCell
                return modelOfTableCell[cell]
            }else{
                return nil
            }
        }
    }
    
    
    func indexPath()->Int {
        guard let path = self.path else { return 0}
        return path
    }
}


