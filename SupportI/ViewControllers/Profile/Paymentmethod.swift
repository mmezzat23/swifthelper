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
    var cardsdata : [CardsItem] = []
    var viewModel : ProfileViewModel?
    @IBOutlet weak var credit: UIButton!
    @IBOutlet weak var cash: UIButton!
    @IBOutlet weak var wallet: UIButton!
    @IBOutlet weak var cardshight: NSLayoutConstraint!
    var type = 0
    var parameters : [String : Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
    }
    
    func setup() {
        payment.delegate = self
        payment.dataSource = self
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.getcards()
    }
    override func bind() {
        viewModel?.cardsData.bind({ [weak self](data) in
            self?.stopLoading()
            self?.cardsdata.append(contentsOf: data.responseData?.credits?.items ?? [])
            self?.payment.reloadData()
            self?.type = data.responseData?.paymentMethod ?? 0
            if (self?.type == 0){
                self?.cash.setImage(#imageLiteral(resourceName: "Check Box"), for: .normal)
                self?.credit.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
                self?.wallet.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
            }else if (self?.type == 1){
                self?.credit.setImage(#imageLiteral(resourceName: "Check Box"), for: .normal)
                self?.cash.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
                self?.wallet.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
            }else {
                self?.wallet.setImage(#imageLiteral(resourceName: "Check Box"), for: .normal)
                self?.credit.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
                self?.cash.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
            }
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
       
    }
    @IBAction func credit(_ sender: Any) {
        type = 1
        credit.setImage(#imageLiteral(resourceName: "Check Box"), for: .normal)
        cash.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
        wallet.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
        viewModel?.editpayment(type: String(type))

        
    }
    @IBAction func cash(_ sender: Any) {
        type = 0
        cash.setImage(#imageLiteral(resourceName: "Check Box"), for: .normal)
        credit.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
        wallet.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
        viewModel?.editpayment(type: String(type))


    }
    @IBAction func wallet(_ sender: Any) {
        type = 2
        wallet.setImage(#imageLiteral(resourceName: "Check Box"), for: .normal)
        credit.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
        cash.setImage(#imageLiteral(resourceName: "Check Box Area"), for: .normal)
        viewModel?.editpayment(type: String(type))

    }
    
    @IBAction func addcard(_ sender: Any) {
        let vcc = self.pushViewController(Addcard.self,storyboard: .profile)
        self.push(vcc)
    }
    

}
extension Paymentmethod:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        payment.swipeButtomRefresh {
            if case self.viewModel?.runPaginator() = true {
                self.viewModel?.getcards()
            } else {
                self.payment.stopSwipeButtom()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: PaymentTableViewCell.self, indexPath)
        cell.model = cardsdata[indexPath.row]
        cell.setup()
        if (indexPath.row == 0){
            cell.isdefult.isHidden = false
        }else{
            cell.isdefult.isHidden = true
        }
        cardshight.constant = CGFloat(cardsdata.count * 90)
        return cell
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action =  UIContextualAction(style: .destructive, title: "", handler: { [self] (action,view,completionHandler ) in
            let vcc = self.pushViewController(Deletecard.self,storyboard: .profile)
            vcc.id = cardsdata[indexPath.row].id ?? 0
            vcc.txt =  cardsdata[indexPath.row].cardNumber ?? ""
            pushPop(vcr: vcc)
            completionHandler(true)
            })
            
            action.image = UIImage(named: "Fill -2")
            
        action.backgroundColor = UIColor(red: 0x01, green: 0x14, blue: 0x47)
        let editaction =  UIContextualAction(style: .destructive, title: "", handler: { [self] (action, view, completionHandler ) in
                self.startLoading()
                let vcc = self.pushViewController(Addcard.self,storyboard: .profile)
                vcc.id = cardsdata[indexPath.row].id ?? 0
                vcc.expirytxt = cardsdata[indexPath.row].expiry ?? ""
                vcc.nametxt = cardsdata[indexPath.row].holderName ?? ""
                vcc.num = cardsdata[indexPath.row].cardNumber ?? ""
                vcc.isedit = true
                self.push(vcc)
                completionHandler(true)
            })
            
            editaction.image = UIImage(named: "edit-1")

            editaction.backgroundColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            let confrigation = UISwipeActionsConfiguration(actions: [action , editaction])
            return confrigation
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
    
}
