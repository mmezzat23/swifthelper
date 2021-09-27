//
//  PaymentTableViewCell.swift
//  SupportI
//
//  Created by Adam on 9/23/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell , CellProtocol{
    @IBOutlet weak var isdefult: UILabel!
    @IBOutlet weak var visanumber: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func setup() {
        guard let model = model as? CardsItem else { return }
        name.text = model.holderName
        let index = model.cardNumber!.index(model.cardNumber!.endIndex, offsetBy: -4)
        let mySubstring = model.cardNumber!.suffix(from: index) // playground
         visanumber.text = "****\(mySubstring)"
        
    }
    
}
