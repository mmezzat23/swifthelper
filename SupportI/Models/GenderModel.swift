//
//  GenderModel.swift
//  SupportI
//
//  Created by Adam on 9/27/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct GenderModel: Codable {
    var type: String?
    var name: String?
    init(type: String, name: String!) {
        self.name = name
        self.type = type
    }
}
