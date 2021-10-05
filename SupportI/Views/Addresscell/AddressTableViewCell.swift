//
//  AddressTableViewCell.swift
//  SupportI
//
//  Created by Adam on 9/23/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell , CellProtocol {
    @IBOutlet weak var imageicon: UIButton!
    @IBOutlet weak var isdefult: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addresstitle: UILabel!
    @IBOutlet weak var more: UIImageView!
    
    
    func setup() {
        guard let model = model as? ItemAddress else { return }
        addresstitle.text = model.name
        address.text = "\(model.buildingNo ?? 0) , \(model.street ?? "") , \(model.city?.name ?? "")"
        if (model.isDefault == true){
            isdefult.isHidden = false
        }else{
            isdefult.isHidden = true
        }
        
    }
}
