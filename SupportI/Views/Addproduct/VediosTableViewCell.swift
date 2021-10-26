//
//  VediosTableViewCell.swift
//  Wndo
//
//  Created by Adam on 26/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import AVFoundation
protocol VediosTableViewCellDelegate: class {
    func more(wasPressedOnCell cell: VediosTableViewCell , path : Int)
   
}
class VediosTableViewCell: UITableViewCell , CellProtocol {
    @IBOutlet weak var vediosimage: UIImageView!
    @IBOutlet weak var minute: UILabel!
    @IBOutlet weak var vedioname: UILabel!
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var vediodes: UILabel!
    weak var delegate : VediosTableViewCellDelegate?

    @IBOutlet weak var productname: UILabel!
    func setup() {
        guard let model = model as? VediosModelitem else { return }
        vedioname.text = model.name ?? ""
        productname.text = model.productName ?? ""
        vediodes.text = model.itemDescription ?? ""
        vediosimage.setImage(url: model.urlThumbnail ?? "")
        let asset = AVURLAsset(url: URL(string : model.urlPreview ?? "")!)
        let durationInSeconds = asset.duration.seconds
        minute.text = "0\(Int(durationInSeconds)/60):\(Int(durationInSeconds) % 60)"
        if (model.isMain ?? false == true) {
            more.isHidden = true
        }else{
            more.isHidden = false
        }
        more.UIViewAction { [self] in
            delegate?.more(wasPressedOnCell: self , path: indexPath())
        }
    }

  
    
}
