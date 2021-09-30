//
//  Deleteaccount.swift
//  SupportI
//
//  Created by Adam on 9/30/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct DeleteaccountModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: String?
}
