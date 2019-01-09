//
//  User.swift
//  homeCheif
//
//  Created by Algazzar on 4/1/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import CoreData

class BaseModel:Decodable {
    
    
    var success: Bool?
    var message:String?
    var errors:Errors?
  
    public static func convertToModel(response:Data?)->BaseModel{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
            
        }catch{
            print("error")
            return BaseModel()
        }
        
    }
    
   
    
    public static func storeInDefault(key:String , value:Any) {
    
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
        
    }
    
}



