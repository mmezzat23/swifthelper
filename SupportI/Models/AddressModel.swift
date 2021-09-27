//
//  AddressModel.swift
//  SupportI
//
//  Created by Adam on 9/27/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation


struct AddressModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: ResponseDataAddress?
}

// MARK: - ResponseData
struct ResponseDataAddress: Codable {
    let totalCount: Int?
    let items: [ItemAddress]?
}

// MARK: - Item
struct ItemAddress: Codable {
    let name, street: String?
    let buildingNo: Int?
    let landMark: String?
    let isDefault: Bool?
    let city: Cityaddress?
    let lat, long, location: String?
    let id: Int?
}

// MARK: - City
struct Cityaddress: Codable {
    let name: String?
    let countryDto: CountryDtoaddress?
    let id: Int?
}

// MARK: - CountryDto
struct CountryDtoaddress: Codable {
    let name: String?
    let id: Int?
}
