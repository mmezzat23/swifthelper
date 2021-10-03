//
//  NotificationsViewController.swift
//  SupportI
//
//  Created by Kareem on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class NotificationsViewController: BaseController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var notificationsTableView: UITableView! {
        didSet {
            notificationsTableView.dataSource = self
            notificationsTableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsTableView.tableFooterView = UIView()
    }
    
    @IBAction func clearBtnClicked(_ sender: UIButton) {
    }
    
}

extension NotificationsViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(type: NotificationsTableViewCell.self , indexPath)
        return cell
    }
    
}
