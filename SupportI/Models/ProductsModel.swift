//
//  ProductsModel.swift
//  Wndo
//
//  Created by Adam on 21/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct ProductsModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: [ProductsResponseDatum]?
}

// MARK: - ResponseDatum
struct ProductsResponseDatum: Codable {
    let name, responseDatumDescription: String?
    let status: Int?
    let category, subCategory: ProductsCategory?
    let price, priceAfterDiscount: Int?
    let image: ProductsImage?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name
        case responseDatumDescription = "description"
        case status, category, subCategory, price, priceAfterDiscount, image, id
    }
}

// MARK: - Category
struct ProductsCategory: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Image
struct ProductsImage: Codable {
    let imageID, urlThumbnail, urlPreview, urlDownload, videoId: String?

    enum CodingKeys: String, CodingKey {
        case imageID = "imageId"
        case urlThumbnail, urlPreview, urlDownload, videoId
    }
}
