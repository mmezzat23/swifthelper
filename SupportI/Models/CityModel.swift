//
//  CityModel.swift
//  SupportI
//
//  Created by Adam on 9/27/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct CityModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: ResponseDataCity?
}

// MARK: - ResponseData
struct ResponseDataCity: Codable {
    let totalCount: Int?
    let items: [ItemCity]?
}

// MARK: - Item
struct ItemCity: Codable {
    let name: String?
    let countryDto: CountryDto?
    let id: Int?
}

// MARK: - CountryDto
struct CountryDto: Codable {
    let name: String?
    let id: Int?
}
