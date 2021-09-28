//
//  FaqsModel.swift
//  SupportI
//
//  Created by Adam on 9/28/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct FaqsModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: ResponseDataFaq?
}

// MARK: - ResponseData
struct ResponseDataFaq: Codable {
    let totalCount: Int?
    let items: [ItemFaq]?
}

// MARK: - Item
struct ItemFaq: Codable {
    let question, answer: String?
    let isSeller: Bool?
    let id: Int?
}
