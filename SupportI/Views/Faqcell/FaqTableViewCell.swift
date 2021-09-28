//
//  FaqTableViewCell.swift
//  SupportI
//
//  Created by Adam on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class FaqTableViewCell: UITableViewCell , CellProtocol {
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var des: UILabel!
    
    func setup() {
        guard let model = model as? ItemFaq else { return }
        titlelbl.text = model.question
        des.text = " "
        add.UIViewAction { [self] in
            if (des.text != " "){
                des.text = " "
                add.setImage(#imageLiteral(resourceName: "Fill 1042"), for: .normal)
            }else{
                des.text = model.answer
                add.setImage(#imageLiteral(resourceName: "icon_plus"), for: .normal)
            }
        }
        
    }
}
