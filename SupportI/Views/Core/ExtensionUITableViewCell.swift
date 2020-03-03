//
//  ExtensionUITableViewCell.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 6/21/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    /// func cell Template
    ///
    /// - Parameters:
    ///   - cell: Template
    ///   - indexPath: indexpath
    ///   - register: register
    /// - Returns: return the template cell
    func cell<T>(type: T.Type, _ indexPath: IndexPath, register: Bool = true) -> T {

        let ind = String(describing: type)
        if register {
            self.register(UINib(nibName: ind, bundle: nil), forCellReuseIdentifier: ind)
        }
        let cellProt = self.dequeueReusableCell(withIdentifier: ind, for: indexPath) as? T
        if cellProt is CellProtocol {
            var cell = cellProt as? CellProtocol
            cell?.path = indexPath.item
            if let cell = cell as? T {
                return cell
            } else {
                return cellProt!
            }
        } else {
            return cellProt!
        }

    }
//    func cell<T>(type:T.Type , _ indexPath:IndexPath , register:Bool = true)-> T? {
//        do{
//            return try cellTemplate(type: type, indexPath,register: register)
//        }catch{
//            print(error.localizedDescription)
//            return nil
//        }
//
//    }
}
