//
//  SelectDropDownModel.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 5/3/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation

class SelectDropDownModel:Decodable{
    
    var id: Int?
    var title:String?
    
    public static func convertToModel(response:Data?)->SelectDropDownModel{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
            
        }catch{
            print("error")
            return SelectDropDownModel()
        }
        
    }
    
}
