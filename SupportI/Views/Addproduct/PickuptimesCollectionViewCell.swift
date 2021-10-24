//
//  PickuptimesCollectionViewCell.swift
//  Wndo
//
//  Created by Adam on 21/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol PickuptimesCollectionViewCellDelegate: class {
    func setpikup(wasPressedOnCell cell: PickuptimesCollectionViewCell , path : Int)
}
class PickuptimesCollectionViewCell: UICollectionViewCell , CellProtocol{
    @IBOutlet weak var timeview: UIView!
    @IBOutlet weak var timelabel: UILabel!
    weak var delegate : PickuptimesCollectionViewCellDelegate?

    var type = -1
    func setup() {
        guard let model = model as? GenderModel else { return }
        timelabel.text = model.name
        if (type == Int (model.type ?? "-1") ?? -1){
            timeview.backgroundColor = hexaCodeToColor(hex: "#011447")
            timelabel?.font = UIFont(name: "Muli-Bold.ttf", size: 7)
            timelabel.textColor = hexaCodeToColor(hex: "#ffffff")

        }else {
            timeview.backgroundColor = hexaCodeToColor(hex: "#fafafa")
            timelabel?.font = UIFont(name: "Muli-Light.ttf", size: 7)
            timelabel.textColor = hexaCodeToColor(hex: "#101010")
        }
        timeview.UIViewAction { [self] in
            delegate?.setpikup(wasPressedOnCell: self, path: indexPath())
        }
    }

}
