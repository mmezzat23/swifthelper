//
//  SingleaddressModel.swift
//  SupportI
//
//  Created by Adam on 9/27/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

//
//  AddressModel.swift
//  SupportI
//
//  Created by Adam on 9/27/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation


struct SingleaddressModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: ItemAddress?
}

