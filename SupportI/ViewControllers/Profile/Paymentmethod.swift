//
//  Paymentmethod.swift
//  SupportI
//
//  Created by Adam on 9/23/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Paymentmethod: BaseController {
    @IBOutlet weak var payment: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()

        // Do any additional setup after loading the view.
    }
    
    func setup() {
        payment.delegate = self
        payment.dataSource = self
    }
    
    @IBAction func credit(_ sender: Any) {
    }
    @IBAction func cash(_ sender: Any) {
    }
    @IBAction func wallet(_ sender: Any) {
    }
    
    @IBAction func addcard(_ sender: Any) {
        let vcc = self.pushViewController(Addcard.self,storyboard: .profile)
        self.push(vcc)
    }
    

}
extension Paymentmethod:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: PaymentTableViewCell.self, indexPath)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
    
}
