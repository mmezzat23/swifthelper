//
//    RootClass.swift
//
//    Create by imac on 14/5/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PushNotificationModel : Decodable{
    
    
    var body : String?
    //var model: T?
 
    public static func convertToModel(response: Data?) -> PushNotificationModel{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
        }catch{
            return PushNotificationModel()
        }
    }
    
    
    
}
