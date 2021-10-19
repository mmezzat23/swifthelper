//
//  SectionModel.swift
//  Wndo
//
//  Created by Adam on 19/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct SectionModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: SectionSectionModel?
}

// MARK: - ResponseData
struct SectionSectionModel: Codable {
    let totalCount: Int?
    let items: [SectionItem]?
}

// MARK: - Item
struct SectionItem: Codable {
    let name: String?
    let id: Int?
}
