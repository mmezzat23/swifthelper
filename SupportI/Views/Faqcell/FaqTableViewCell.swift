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
    @IBOutlet weak var answerview: UIView!
    @IBOutlet weak var answerhight: NSLayoutConstraint!
    
    func setup() {
        guard let model = model as? ItemFaq else { return }
        titlelbl.text = model.question
        des.text = " "
//        answerhight.constant = 0
        answerview.isHidden = true

        add.UIViewAction { [self] in
            if (des.text != " "){
                answerview.isHidden = true
                des.text = " "
                add.setImage(#imageLiteral(resourceName: "Fill 1042"), for: .normal)
                titlelbl.font = UIFont(name: "Muli.ttf", size: 0.15)
                titlelbl.textColor = hexaCodeToColor(hex: "#000000")
            }else{
                des.text = model.answer
                add.setImage(#imageLiteral(resourceName: "icon_plus"), for: .normal)
                answerview.isHidden = false
                titlelbl.textColor = hexaCodeToColor(hex: "#011447")
                titlelbl.font = UIFont(name: "Muli-SemiBold.ttf", size: 0.15)
                
//                answerhight.constant = CGFloat(des.maxNumberOfLines * 40)
            }
        }
        
    }
}
