//
//  VediosModel.swift
//  Wndo
//
//  Created by Adam on 26/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct VediosModel: Codable {
    let isSuccess: Bool?
    let errorMessage: String?
    let statusCode: Int?
    let responseData: VediosModelResponseData?
}

// MARK: - ResponseData
struct VediosModelResponseData: Codable {
    let totalCount: Int?
    let items: [VediosModelitem]?
}

// MARK: - Item
struct VediosModelitem: Codable {
    let name, itemDescription, videoID, productID: String?
    let urlThumbnail: String?
    let urlPreview: String?
    let urlDownload: String?
    let isMain: Bool?
    let productName: String?
    let id: Int?
    enum CodingKeys: String, CodingKey {
        case  name, videoID, productID
        case itemDescription = "description"
        case urlThumbnail, urlPreview, urlDownload, isMain, productName, id
    }
}
