//
//  Cards.swift
//  SupportI
//
//  Created by Adam on 9/26/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cards = try? newJSONDecoder().decode(Cards.self, from: jsonData)

import Foundation

// MARK: - Cards
struct Cards: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: ResponseData?
}
struct Deletecards: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
}
// MARK: - ResponseData
struct ResponseData: Codable {
    let totalCount: Int?
    let items: [CardsItem]?

}

// MARK: - Item
struct CardsItem: Codable {
    let holderName, expiry, cardNumber: String?
    let id: Int?

    
}
