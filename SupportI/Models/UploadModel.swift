//
//  UploadModel.swift
//  Wndo
//
//  Created by Adam on 20/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

struct UploadModel: Codable {
    let success: Bool
    let code: Int
    let id: String
    let publicID: String?
    let title, uploadModelDescription, tags, type: String
    let uploadModelExtension: String
    let size, width, height: Int
    let privacy, optionDownload, optionAd, optionTransform: String
    let wmID: String?
    let urlPreview: String
    let versions, hits: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case success, code, id
        case publicID = "public_id"
        case title
        case uploadModelDescription = "description"
        case tags, type
        case uploadModelExtension = "extension"
        case size, width, height, privacy
        case optionDownload = "option_download"
        case optionAd = "option_ad"
        case optionTransform = "option_transform"
        case wmID = "wm_id"
        case urlPreview = "url_preview"
        case versions, hits
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
