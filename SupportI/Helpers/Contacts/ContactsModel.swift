//
//  Contacts.swift
//  NashmiClient
//
//  Created by mohamed abdo on 8/21/18.
//  Copyright © 2018 Nashmi. All rights reserved.
//

import Foundation
import CoreData
import Contacts

class ContactsModel:Codable {
    var result:[ContactsResult]?
    
    public static func convertToModel(response: Data?) -> ContactsModel{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
        }catch{
            return ContactsModel()
        }
    }
    public func convertToJson()->Data?{
        do{
            let data = try JSONEncoder().encode(self)
            return data
        }catch{
            return nil
        }
        
    }
}
class ContactsResult:Codable {
    var id:Int?
    var name:String?
    var image:String?
    var imageData:Data?
    var mobile:String?
    
}
