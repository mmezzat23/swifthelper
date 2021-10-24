//
//  LookupshowTableViewCell.swift
//  Wndo
//
//  Created by Adam on 24/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class LookupshowTableViewCell: UITableViewCell , CellProtocol {
    @IBOutlet weak var lookuptable: UILabel!
    @IBOutlet weak var lookupdes: UILabel!
   
    func setup() {
        guard let model = model as? LookupDto else { return }
        lookuptable.text = model.displayName ?? ""
        lookupdes.text = model.lookupValues?[0].displayName ?? ""

    }
}
