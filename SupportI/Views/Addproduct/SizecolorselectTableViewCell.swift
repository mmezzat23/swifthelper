//
//  SizecolorselectTableViewCell.swift
//  Wndo
//
//  Created by Adam on 24/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class SizecolorselectTableViewCell: UITableViewCell , CellProtocol {
    @IBOutlet weak var colorview: UIView!
    @IBOutlet weak var color: UIView!
    @IBOutlet weak var colorlbl: UILabel!
    @IBOutlet weak var sizeview: UIView!
    @IBOutlet weak var sizelbl: UILabel!
    @IBOutlet weak var qunatity: UILabel!
    
    func setup() {
        guard let model = model as? ProductColorSize else { return }
        if (model.sizeID ?? 0 == 0){
            sizeview.isHidden = true
        }
        if (model.colorID ?? 0 == 0){
            colorview.isHidden = true
        }
        colorlbl.text = model.colorName ?? ""
        sizelbl.text = model.sizeName ?? ""
        qunatity.text = String(model.quantity ?? 0)
        color.backgroundColor = hexaCodeToColor(hex: "#" + model.colorHexaCode! ?? "")

    }
    
}
