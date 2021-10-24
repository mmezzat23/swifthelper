//
//  imagesshowCollectionViewCell.swift
//  Wndo
//
//  Created by Adam on 24/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class imagesshowCollectionViewCell: UICollectionViewCell , CellProtocol {
    @IBOutlet weak var imageinfo: UIImageView!
    
    func setup() {
        guard let model = model as? ProductsImage else { return }
        imageinfo.setImage(url: model.urlThumbnail)

    }
}
