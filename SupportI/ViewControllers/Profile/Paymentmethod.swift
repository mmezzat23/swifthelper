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
    
    @IBOutlet weak var getpromotxt: UILabel!
    @IBOutlet weak var getpromoimg: UIImageView!
    @IBOutlet weak var promotxt: UILabel!
    @IBOutlet weak var promonum: UILabel!
    @IBOutlet weak var balancetxt: UILabel!
    @IBOutlet weak var wallettxt: UILabel!
    @IBOutlet weak var walletview: UIView!
    @IBOutlet weak var credittxt: UILabel!
    @IBOutlet weak var creditview: UIView!
    @IBOutlet weak var cashview: UIView!
    @IBOutlet weak var cashtxt: UILabel!
    var type = 0
    var path = 0
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
                self?.cash.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
                self?.credit.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
                self?.wallet.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
                self?.cashtxt.textColor = UIColor(red: 0x01, green: 0x14, blue: 0x47)
                self?.cashview.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
                self?.credittxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.creditview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.wallettxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.walletview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
            }else if (self?.type == 1){
                self?.credit.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
                self?.cash.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
                self?.wallet.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
                self?.credittxt.textColor = UIColor(red: 0x01, green: 0x14, blue: 0x47)
                self?.creditview.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
                self?.cashtxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.cashview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.wallettxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.walletview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
            }else {
                self?.wallettxt.textColor = UIColor(red: 0x01, green: 0x14, blue: 0x47)
                self?.walletview.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
                self?.cashtxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.cashview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.credittxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.creditview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
                self?.wallet.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
                self?.credit.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
                self?.cash.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
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
        credittxt.textColor = UIColor(red: 0x01, green: 0x14, blue: 0x47)
        creditview.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
        cashtxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        cashview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        wallettxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        walletview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        credit.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
        cash.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
        wallet.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
        viewModel?.editpayment(type: String(type))

        
    }
    @IBAction func cash(_ sender: Any) {
        type = 0
        cashtxt.textColor = UIColor(red: 0x01, green: 0x14, blue: 0x47)
        cashview.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
        credittxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        creditview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        wallettxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        walletview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        cash.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
        credit.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
        wallet.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
        viewModel?.editpayment(type: String(type))


    }
    @IBAction func wallet(_ sender: Any) {
        type = 2
        wallettxt.textColor = UIColor(red: 0x01, green: 0x14, blue: 0x47)
        walletview.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
        cashtxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        cashview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        credittxt.textColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        creditview.borderColor = UIColor(red: 0x96, green: 0xA1, blue: 0xAB)
        wallet.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
        credit.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
        cash.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
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
        cardshight.constant = CGFloat(cardsdata.count * 90)
        cell.more.UIViewAction { [self] in
            path = indexPath.row
            let vcc = self.pushViewController(Editdeleteoption.self,storyboard: .profile)
            vcc.type =  "2"
            vcc.delegate = self
            self.pushPop(vcr: vcc)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
    
}
extension Paymentmethod : EditdeleteoptionDelegate  {
    func settype(type: String?, action: String?) {
        if (action == "delete") {
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                let vcc = self.pushViewController(Deletecard.self,storyboard: .profile)
                vcc.id = cardsdata[path].id ?? 0
                vcc.txt =  cardsdata[path].cardNumber ?? ""
                vcc.type =  "2"
                pushPop(vcr: vcc)
            }
           
        }else {
            let vcc = self.pushViewController(Addcard.self,storyboard: .profile)
            vcc.id = cardsdata[path].id ?? 0
            vcc.expirytxt = cardsdata[path].expiry ?? ""
            vcc.nametxt = cardsdata[path].holderName ?? ""
            vcc.num = cardsdata[path].cardNumber ?? ""
            vcc.cardtxt = cardsdata[path].cardName ?? ""
            vcc.isdefultvalue = cardsdata[path].isDefault ?? false
            vcc.isedit = true
            self.push(vcc)
        }
    }
    
    
    
}
