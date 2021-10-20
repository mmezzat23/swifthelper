//
//  ImagesCollectionViewCell.swift
//  Wndo
//
//  Created by Adam on 20/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell , CellProtocol{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var delete: UIImageView!
    var type = 0
    func setup() {
       
        if (type != 0 ){
            guard let model = model as? String else { return setupModel() }
            image.setImage(url: model)
            image.borderColor = UIColor(red: 1, green: 20, blue: 71)
            image.borderWidth = 1
            image?.cornerRadius = 10
            delete.isHidden = false

        }else{
            guard let model = model as? UIImage else { return setupModel() }
            image.image = model
            image.borderColor = UIColor(red: 1, green: 20, blue: 71)
            image.borderWidth = 1
            image?.cornerRadius = 10
            delete.isHidden = false
        }
    }
    func setupModel() {
        image.image = #imageLiteral(resourceName: "Group 11407")
//        guard let model = model as? ImageEditPicker else { return }
//        if model.image != nil {
//            image.image = model.image
//        } else {
//            image.setImage(url: model.url)
//        }
    }
}
