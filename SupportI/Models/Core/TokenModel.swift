//
//  TokenModel.swift
//  RedBricks
//
//  Created by Mohamed Abdu on 6/10/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation

class TokenModel : Decodable {
    
    var data : String?
    var expires_in : Int?
    var access_token : String?
    var refresh_token : String?
   
}
