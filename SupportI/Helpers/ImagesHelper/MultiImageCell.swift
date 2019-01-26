//
//  SliderCell.swift
//  Jalab
//
//  Created by Mohamed Abdu on 7/12/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

class MultiImageCell: UICollectionViewCell,CellProtocol {

    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setup() {
        guard let data = self.model as? String else { return }
        imageView.setImage(url: data)
    }

}
