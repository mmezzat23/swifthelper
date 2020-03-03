//
//  ExtensionUITableViewCell.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 6/21/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func calculateMargin(_ margin: Int = 20) -> CGFloat {

        let margin = (self.frame.size.width / 100) * margin.cgFloat
        let width = (self.frame.size.width - margin)

        return width
    }
}
extension UICollectionView {
    /// func cell Template
    ///
    /// - Parameters:
    ///   - cell: Template
    ///   - indexPath: indexpath
    ///   - register: register
    /// - Returns: return the template cell
    func cellTemplate<T>(type: T.Type, _ indexPath: IndexPath, register: Bool = true) throws -> T {
        let ind = String(describing: type)
        if register {
            self.register(UINib(nibName: ind, bundle: nil), forCellWithReuseIdentifier: ind)
        }

        guard let cellProtcol = self.dequeueReusableCell(withReuseIdentifier: ind, for: indexPath) as? T else { throw CellError.confirmProtocol }
        if var cellProtcol = cellProtcol as? CellProtocol {
            cellProtcol.path = indexPath.item
            if let cell = cellProtcol as? T {
                return cell
            } else {
                fatalError("DequeueReusableCell failed while casting")
            }
        } else {
            throw CellError.confirmProtocol
        }

    }
    func cell<T>(type: T.Type, _ indexPath: IndexPath, register: Bool = true) -> T {
        let ind = String(describing: type)
        if register {
            self.register(UINib(nibName: ind, bundle: nil), forCellWithReuseIdentifier: ind)
        }
        let cellProtcol = self.dequeueReusableCell(withReuseIdentifier: ind, for: indexPath) as? T
        if var cell = cellProtcol as? CellProtocol {
            cell.path = indexPath.item
            if let cell = cell as? T {
                return cell
            } else {
                return cellProtcol!
            }
        } else {
            return cellProtcol!
        }
    }
//    func cell<T>(type:T.Type , _ indexPath:IndexPath , register:Bool = true)-> T?{
//        do{
//            return try cellTemplate(type: type, indexPath,register: register)
//        }catch{
//            print(error.localizedDescription)
//            return nil
//        }
//
//    }
}
