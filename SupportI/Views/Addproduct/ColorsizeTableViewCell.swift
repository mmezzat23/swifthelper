//
//  ColorsizeTableViewCell.swift
//  Wndo
//
//  Created by Adam on 20/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol ColorsizeTableViewCellDelegate: class {
    func setcolor(wasPressedOnCell cell: ColorsizeTableViewCell , path : Int)
    func setsize(wasPressedOnCell cell: ColorsizeTableViewCell , path : Int)
    func setqunatity(wasPressedOnCell cell: ColorsizeTableViewCell , path : Int , quantity : String)
    func addrow(wasPressedOnCell cell: ColorsizeTableViewCell , path : Int)

}

class ColorsizeTableViewCell: UITableViewCell , CellProtocol {
    @IBOutlet weak var color: UIView!
    @IBOutlet weak var colorview: UIView!
    @IBOutlet weak var colorlbl: UILabel!
    @IBOutlet weak var colorclickview: UIView!
    @IBOutlet weak var sizeview: UIView!
    @IBOutlet weak var sizeviewclick: UIView!
    @IBOutlet weak var sizelbl: UILabel!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var add: UIButton!
    weak var delegate : ColorsizeTableViewCellDelegate?

    
    func setup() {
        guard let model = model as? ColorsizeModel else { return }
        quantity.text = model.quantity
        if (model.issize == false){
            sizeview.isHidden = true
        }
        if (model.iscolor == false){
            color.isHidden = true
        }
        if (model.colorid > 0){
            colorlbl.text = model.colortxt
            colorlbl.textColor = UIColor(red: 1, green: 20, blue: 71)
        }else {
            colorlbl.text = "Select Color".localized()
            colorlbl.textColor = UIColor(red: 150, green: 161, blue: 171)
        }
        if (model.sizeid > 0){
            sizelbl.text = model.sizetxt
            sizelbl.textColor = UIColor(red: 1, green: 20, blue: 71)

        }else {
            sizelbl.text = "Select Size".localized()
            sizelbl.textColor = UIColor(red: 150, green: 161, blue: 171)
        }
        sizeviewclick.UIViewAction { [self] in
            delegate?.setsize(wasPressedOnCell: self , path: indexPath())
        }
        colorclickview.UIViewAction { [self] in
            delegate?.setcolor(wasPressedOnCell: self , path: indexPath())
        }
        add.UIViewAction { [self] in
            delegate?.addrow(wasPressedOnCell: self , path: indexPath())
        }
    }
    
    @IBAction func changequnatity(_ sender: Any) {
        delegate?.setqunatity(wasPressedOnCell: self , path: indexPath(), quantity: quantity.text! ?? "")

    }
}
