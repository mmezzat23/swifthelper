//
//  ProductdetailModel.swift
//  Wndo
//
//  Created by Adam on 21/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

// MARK: - ProductdetailModel
struct ProductdetailModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: ProductdetailResponseData?
}

// MARK: - ResponseData
struct ProductdetailResponseData: Codable {
    let name, responseDataDescription: String?
    let status: Int?
    let category, subCategory, section: ProductsCategory?
    let price: Price?
    let productShipping: ProductShipping?
    let seller: Seller?
    let productTags: [ProductTag]?
    let productColorSizes: [ProductColorSize]?
    let videos, images: [ProductsImage]?
    let lookupDtos: [LookupDto]?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name
        case responseDataDescription = "description"
        case status, category, subCategory, section, price, productShipping, seller, productTags, productColorSizes, videos, images, lookupDtos, id
    }
}

// MARK: - Category


// MARK: - LookupDto
struct LookupDto: Codable {
    let displayName: String?
    let isMultiChoice: Bool?
    let lookupValues: [LookupValue]?
    let id: Int?
}

// MARK: - LookupValue
struct LookupValue: Codable {
    let displayName: String?
    let isSelected: Bool?
    let id: Int?
}

// MARK: - Price
struct Price: Codable {
    let price, discount: Int?
    let isPermanent: Bool?
    let expiryDate: String?
    let priceAfterOffer, wndoCommission, shippingFees, taxes: Int?
}

// MARK: - ProductColorSize
struct ProductColorSize: Codable {
    let sizeID: Int?
    let sizeName, colorName: String?
    let colorID, quantity, id: Int?

    enum CodingKeys: String, CodingKey {
        case sizeID = "sizeId"
        case sizeName, colorName
        case colorID = "colorId"
        case quantity, id
    }
}

// MARK: - ProductShipping
struct ProductShipping: Codable {
    let deliveryMethod, pickUpTime, addressID: Int?
    let addressName: String?
    let preparationTime: Int?

    enum CodingKeys: String, CodingKey {
        case deliveryMethod, pickUpTime
        case addressID = "addressId"
        case addressName, preparationTime
    }
}

// MARK: - ProductTag
struct ProductTag: Codable {
    let tagName: String?
    let tagID: Int?

    enum CodingKeys: String, CodingKey {
        case tagName
        case tagID = "tagId"
    }
}

// MARK: - Seller
struct Seller: Codable {
    let name: String?
    let email, phoneNumber, id: String?
}
