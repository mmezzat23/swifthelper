//
//  ProductsTableViewCell.swift
//  Wndo
//
//  Created by Adam on 21/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol ProductsTableViewCellDelegate: class {
    func more(wasPressedOnCell cell: ProductsTableViewCell , path : Int)
   
}
class ProductsTableViewCell: UITableViewCell , CellProtocol {
    @IBOutlet weak var productimg: UIImageView!
    @IBOutlet weak var ratenum: UILabel!
    @IBOutlet weak var vedionum: UILabel!
    @IBOutlet weak var statuslbl: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var discountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var catlbl: UILabel!
    @IBOutlet weak var ordernum: UILabel!
    weak var delegate : ProductsTableViewCellDelegate?

    @IBOutlet weak var rateview: UIView!
    @IBOutlet weak var tagimg: UIImageView!
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var revenuelbl: UILabel!
    @IBOutlet weak var discounthight: NSLayoutConstraint!
    
    func setup() {
        guard let model = model as? ProductsResponseDatum else { return }
        productname.text = model.name ?? ""
        if (model.priceAfterDiscount ?? 0 > 0){
            discountlbl.attributedText = "\(model.price ?? 0) EGP".strikeThrough()
            pricelbl.text = "\(model.priceAfterDiscount ?? 0) EGP"
            discounthight.constant = 5
        }else {
            discountlbl.text = ""
            pricelbl.text = "\(model.price ?? 0) EGP"
            discounthight.constant = 0

        }
        vedionum.text = "(\(model.videosCount ?? 0))"
        catlbl.text = "\(model.subCategory?.name ?? "") / \(model.category?.name ?? "" )"
        productimg.setImage(url: model.image?.urlThumbnail ?? "")
        if (model.status == 0){
            statuslbl.text = "Draft".localized()
            tagimg.image = #imageLiteral(resourceName: "tag-3")
        }else if (model.status == 1){
            statuslbl.text = "Pending".localized()
            tagimg.image = #imageLiteral(resourceName: "tag")
        }else if (model.status == 2){
            statuslbl.text = "Approved".localized()
            tagimg.image = #imageLiteral(resourceName: "tag-2")
        }else if (model.status == 3){
            statuslbl.text = "Rejected".localized()
            tagimg.image = #imageLiteral(resourceName: "tag-4")
        }
        more.UIViewAction { [self] in
            delegate?.more(wasPressedOnCell: self , path: indexPath())
        }
    }
}
