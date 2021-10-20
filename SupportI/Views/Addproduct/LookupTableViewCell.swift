//
//  LookupTableViewCell.swift
//  Wndo
//
//  Created by Adam on 20/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol LookupTableViewCellDelegate: class {
    func setlookyp(wasPressedOnCell cell: LookupTableViewCell , path : Int)
}

class LookupTableViewCell: UITableViewCell , CellProtocol {
    @IBOutlet weak var lookupname: UILabel!
    @IBOutlet weak var lookupselectlbl: UILabel!
    @IBOutlet weak var lookup: UIView!
    weak var delegate : LookupTableViewCellDelegate?
    func setup() {
        guard let model = model as? Lookup else { return }
        lookupname.text = model.displayName
        if (model.ischoose == true){
            lookupselectlbl.text = model.choosetxt
            lookupselectlbl.textColor = UIColor(red: 1, green: 20, blue: 71)
        }else {
    
            lookupselectlbl.text = "Select".localized() + " " + model.displayName
            lookupselectlbl.textColor = UIColor(red: 150, green: 161, blue: 171)
        }
        lookup.UIViewAction { [self] in
            delegate?.setlookyp(wasPressedOnCell: self , path: indexPath())
        }
    }
    
}
