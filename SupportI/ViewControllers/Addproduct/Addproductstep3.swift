//
//  Addproductstep3.swift
//  Wndo
//
//  Created by Adam on 12/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addproductstep3: BaseController {

    @IBOutlet weak var dateimage: UIImageView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var validlbl: UILabel!
    @IBOutlet weak var reviewlbl: UILabel!
    @IBOutlet weak var reviewview: UIView!
    @IBOutlet weak var taxes: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var commisionlbl: UILabel!
    @IBOutlet weak var dicountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var buyerprice: UILabel!
    @IBOutlet weak var pricesummary: UILabel!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var pricetxt: UITextField!
    var productid = ""
    var isPermanent = false
    @IBOutlet weak var totalprice: UILabel!
    var date = ""
    var viewModel : SallerViewModel?
    var parameters : [String : Any] = [:]
    var isveify = false
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        fees.text = "0 EGP"
        taxes.text = "0 EGP"

    }
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        dateimage.UIViewAction { [self] in
            if (discount.text != ""){
                let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
                vcc.openWhat = "date"
                vcc.returnedKey = "start"
                vcc.date = date
                vcc.isproduct = true
                vcc.delegate = self
                pushPop(vcr: vcc)
            }
        }
        datelbl.UIViewAction { [self] in
            if (discount.text != ""){
                let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
                vcc.openWhat = "date"
                vcc.returnedKey = "start"
                vcc.date = date
                vcc.isproduct = true
                vcc.delegate = self
                pushPop(vcr: vcc)
            }
        }
        reviewview.UIViewAction { [self] in
            if (validateTextFields()){
                isveify == false
                parameters["price"] = pricetxt.text ?? ""
                parameters["isPermanent"] = isPermanent
                parameters["productId"] = productid
                if (discount.text != ""){
                    parameters["discount"] = discount.text
                }
    //            if (isedit == true){
    //                parameters["id"] = id
    //                viewModel?.editcard(paramters: parameters)
    //            }else{
                    viewModel?.addscreen5(paramters: parameters)
    //            }
                
            }
        }
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
                self?.stopLoading()
            if (self?.isveify == true){
                let vcc = self?.pushViewController(Reviewproduct.self,storyboard: .addproduct)
                vcc?.productid = data.responseData?.productId ?? ""
                self?.push(vcc!)
            }else {
                self?.viewModel?.puplishproducr(id: productid)
            }
        })
        viewModel?.puplishdata.bind({ [weak self](data) in
                self?.stopLoading()
                let vcc = self?.pushViewController(Successsentproduct.self,storyboard: .addproduct)
                vcc?.txt = "Prouduct is added successfully"
                self?.push(vcc!)
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    @IBAction func discountchange(_ sender: Any) {
        if (pricetxt.text != ""){
            let discountvalue = Int(discount.text ?? "0" ) ?? 0
            self.dicountlbl.text = "\(Int(pricetxt.text ?? "0") ?? 0 * (discountvalue / 100)) EGP"
            totalprice.text = "\((Int(pricetxt.text ?? "") ?? 0 + (Int(pricetxt.text ?? "0") ?? 0 * (5 / 100)) ?? 0 + Int(pricetxt.text ?? "0") ?? 0 * (discountvalue / 100) ?? 0)) EGP"
        }
    }
    @IBAction func pricechange(_ sender: Any) {
        if (discount.text != ""){
            let discountvalue = Int(discount.text ?? "0" ) ?? 0
            self.dicountlbl.text = "\(Int(pricetxt.text ?? "0") ?? 0 * (discountvalue / 100)) EGP"
        }
        buyerprice.text = pricetxt.text ?? "" + " EGP"
        self.commisionlbl.text = "\(Int(pricetxt.text ?? "0") ?? 0 * (5 / 100)) EGP"
        totalprice.text = "\((Int(pricetxt.text ?? "") ?? 0 + (Int(pricetxt.text ?? "0") ?? 0 * (5 / 100)) ?? 0 + Int(pricetxt.text ?? "0") ?? 0 * (Int(discount.text ?? "0" ) ?? 0 / 100) ?? 0)) EGP"
    }
    func validateTextFields() -> Bool {
        pricetxt.customValidationRules = [RequiredRule() ]
        let validator = Validation(textFields: [pricetxt])
        return validator.success
    }
    @IBAction func save(_ sender: Any) {
        if (validateTextFields()){
            isveify == true
            parameters["price"] = pricetxt.text ?? ""
            parameters["isPermanent"] = isPermanent
            parameters["productId"] = productid
            if (discount.text != ""){
                parameters["discount"] = discount.text
            }
//            if (isedit == true){
//                parameters["id"] = id
//                viewModel?.editcard(paramters: parameters)
//            }else{
                viewModel?.addscreen5(paramters: parameters)
//            }
            
        }
    }
    @IBAction func `continue`(_ sender: Any) {
        if (validateTextFields()){
            isveify == false
            parameters["price"] = pricetxt.text ?? ""
            parameters["isPermanent"] = isPermanent
            parameters["productId"] = productid
            if (discount.text != ""){
                parameters["discount"] = discount.text
            }
//            if (isedit == true){
//                parameters["id"] = id
//                viewModel?.editcard(paramters: parameters)
//            }else{
                viewModel?.addscreen5(paramters: parameters)
//            }
            
        }
    }
    @IBAction func payed(_ sender: UIButton) {
        if (isPermanent == false){
            isPermanent = true
            sender.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
        }else{
            isPermanent = false
            sender.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
        }
    }
}
extension Addproductstep3 : PickersPOPDelegate {
    func callbackDate(item: String, returnedKey: String) {
        datelbl.text = item
        date = item
        validlbl.isHidden = false
        datelbl.isHidden = false
    }
    
}
