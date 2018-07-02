//
//  ExtensionUITableViewCell.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 6/21/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation

extension UITableView {
    /// func cell Template
    ///
    /// - Parameters:
    ///   - cell: Template
    ///   - indexPath: indexpath
    ///   - register: register
    /// - Returns: return the template cell
    func cellTemplate<T>(type:T , _ indexPath:IndexPath , register:Bool = true) throws -> T{
        let ind = String (describing: T.self)
        if(register){
            self.register(UINib(nibName: ind, bundle: nil), forCellReuseIdentifier: ind)
        }
        if type is CellProtocol {
            guard var cellProt = self.dequeueReusableCell(withIdentifier: ind, for: indexPath) as? CellProtocol else {throw CellError.confirmProtocol}
            cellProt.path = indexPath.item
            return cellProt as! T
        }else{
            throw CellError.confirmProtocol
        }
        
    }
    /// func cell Template
    ///
    /// - Parameters:
    ///   - cell: Template
    ///   - indexPath: indexpath
    ///   - register: register
    /// - Returns: return the template cell
    func cellTemplate<T>(type:T.Type , _ indexPath:IndexPath , register:Bool = true) throws -> T{
        
        let ind = String (describing: type)
        if(register){
            self.register(UINib(nibName: ind, bundle: nil), forCellReuseIdentifier: ind)
        }
        if type is CellProtocol {
            guard var cellProt = self.dequeueReusableCell(withIdentifier: ind, for: indexPath) as? CellProtocol else {throw CellError.confirmProtocol}
            cellProt.path = indexPath.item
            return cellProt as! T
        }else{
            throw CellError.confirmProtocol
        }
        
    }
    
    
    
    /// func cell  another template
    ///
    /// - Parameters:
    ///   - cell: Template
    ///   - indexPath: indexpath
    ///   - register: register
    /// - Returns: return the template cell
    func cell<T>(type:T , _ indexPath:IndexPath , register:Bool = true)-> T?{
        do{
            return try cellTemplate(type:type, indexPath,register: register)
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    /// func cell Template
    ///
    /// - Parameters:
    ///   - cell: Template
    ///   - indexPath: indexpath
    ///   - register: register
    /// - Returns: return the template cell
    func cell<T>(type:T.Type , _ indexPath:IndexPath , register:Bool = true)-> T?{
        do{
            return try cellTemplate(type: type, indexPath,register: register)
        }catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
    
}
