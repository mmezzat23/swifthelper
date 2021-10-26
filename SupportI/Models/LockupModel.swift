//
//  LockupModel.swift
//  Wndo
//
//  Created by Adam on 20/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct LockupModel: Codable {
    let isSuccess: Bool
    let errorMessage: String?
    let statusCode: Int
    let responseData: LockupResponseData
}

// MARK: - ResponseData
struct LockupResponseData: Codable {
    let isColors, isSizes: Bool
    let lookups: [Lookup]
    let colors: [SectionItem]
    let sizes: [SectionItem]

}

// MARK: - Lookup
struct Lookup: Codable {
    let displayName: String
    var ischoose: Bool?
    var chooseid: Int?
    var choosetxt: String?
    let isMultiChoice: Bool
    let lookupValues: [LookupValue]
    let id: Int
}

// MARK: - LookupValue
struct LookupValue: Codable {
    let displayName: String
    let isSelected: Bool
    let id: Int
}
