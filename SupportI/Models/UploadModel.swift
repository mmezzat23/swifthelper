//
//  UploadModel.swift
//  Wndo
//
//  Created by Adam on 20/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

public struct UploadModel: Codable {
   
    var id: String
    var urlthumbnail ,urldownload: String?
    var urlPreview: String

    enum CodingKeys: String, CodingKey {
        case  id
        case urldownload = "url_download"
        case urlthumbnail = "url_thumbnail"
        case urlPreview = "url_preview"
       
    }
    init(id: String, urldownload: String, urlthumbnail: String, urlPreview: String ) {
        self.id = id
        self.urldownload = urldownload
        self.urlthumbnail = urlthumbnail
        self.urlPreview = urlPreview

      }
}
