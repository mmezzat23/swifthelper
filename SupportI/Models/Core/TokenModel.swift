//
//  TokenModel.swift
//  RedBricks
//
//  Created by Mohamed Abdu on 6/10/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation

class TokenModel : Decodable{
    var data : String?
    var expire : Int?
    var token : String?
    public static func convertToModel(response: Data?) -> TokenModel{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
        }catch{
            return TokenModel()
        }
    }
    
    
}
