//
//  Rejectedproduct.swift
//  Wndo
//
//  Created by Adam on 26/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Rejectedproduct: BaseController {
    @IBOutlet weak var table: UITableView!
    var productdetails: ProductdetailModel?
    var isedit = false
    @IBOutlet weak var raesontxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func setup() {
        table.delegate = self
        table.dataSource = self
    }

    @IBAction func resolve(_ sender: Any) {
        let vcc = self.controller(Addproduct.self,storyboard: .addproduct)
        vcc.productdetails = productdetails
        vcc.isedit = true
        self.push(vcc)
    }
    
}
extension Rejectedproduct:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.cell(type: RejextedTableViewCell.self, indexPath)
            
            return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
    
}
