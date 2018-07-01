//
//  DesignCell.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 4/25/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell,CellProtocol {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    var menu:MenuModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup()  {
        
        if(MenuVC.currentIndex == menu.index){
            itemName.text =  menu.name
            itemImage.image = menu.imageOn
            
        }else{
            itemName.text =  menu.name
            itemImage.image = menu.imageOff
        }
        
    }

}
