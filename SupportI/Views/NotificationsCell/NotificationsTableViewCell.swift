//
//  NotificationsTableViewCell.swift
//  SupportI
//
//  Created by Kareem on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationTime: UILabel!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
