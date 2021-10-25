//
//  Addproductstep3.swift
//  Wndo
//
//  Created by Adam on 12/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addproductstep3: BaseController {

    @IBOutlet weak var samary: UILabel!
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
    var discountval = 0
    var priceval = 0
    var commisionval = 0
    var discountvalue = 0
    var productdetails: ProductdetailModel?
    var isperson = false
    @IBOutlet weak var save: UIButton!
    var isedit = false
    @IBOutlet weak var savedraft: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var payed: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        fees.text = "0 EGP"
        taxes.text = "0 EGP"
        pricesummary.setunderline(title: "Product Price Summary")

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
                isveify = false
                parameters["price"] = pricetxt.text ?? ""
                parameters["isPermanent"] = isPermanent
                parameters["productId"] = productid
                if (discount.text != ""){
                    parameters["discount"] = discount.text
                }
                if (date != ""){
                    parameters["expiryDate"] = date
                }
    //            if (isedit == true){
    //                parameters["id"] = id
    //                viewModel?.editcard(paramters: parameters)
    //            }else{
                    viewModel?.addscreen5(paramters: parameters)
    //            }
                
            }
        }
        if (isedit == true) {
            savedraft.isHidden = true
            cancel.isHidden = false
            pricetxt.text = String(productdetails?.responseData?.price?.price ?? 0)
            discount.text = String(productdetails?.responseData?.price?.discount ?? 0)
            if (productdetails?.responseData?.price?.expiryDate ?? "" != ""){
                datelbl.text = productdetails?.responseData?.price?.expiryDate ?? ""
                date = productdetails?.responseData?.price?.expiryDate ?? ""
                validlbl.isHidden = false
                datelbl.isHidden = false
            }
            var priceval = productdetails?.responseData?.price?.price ?? 0
            var dis = (productdetails?.responseData?.price?.discount)! ?? 0
            var discountval = priceval * dis / 100
            var commisionval = priceval * 5 / 100
            pricelbl.text = "\(productdetails?.responseData?.price?.price ?? 0 ) EGP"
            dicountlbl.text = "\(discountval) EGP"
            fees.text = "\(productdetails?.responseData?.price?.shippingFees ?? 0 ) EGP"
            taxes.text = "\(productdetails?.responseData?.price?.taxes ?? 0 ) EGP"
            commisionlbl.text = "\(commisionval) EGP"
            if (productdetails?.responseData?.price?.isPermanent == true){
                isPermanent = true
                payed.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
            }else{
                isPermanent = false
                payed.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
            }
        }
        if (isperson == true){
            save.setTitle("SAVE".localized(), for: .normal)
        }
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
                self?.stopLoading()
            if (self?.isperson == true){
                let vcc = self?.pushViewController(Reviewproduct.self,storyboard: .addproduct)
                vcc?.productid = data.responseData?.productId ?? ""
                self?.push(vcc!)
            }else {
            if (self?.isveify == false){
                let vcc = self?.pushViewController(Reviewproduct.self,storyboard: .addproduct)
                vcc?.productid = data.responseData?.productId ?? ""
                self?.push(vcc!)
            }else {
                self?.viewModel?.puplishproducr(id: self?.productid ?? "")
            }
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
    
    @IBAction func pricechange(_ sender: UITextField) {
        self.priceval = Int(pricetxt.text ?? "0") ?? 0
        pricelbl.text = "\(self.priceval) EGP"
        self.commisionlbl.text = "\(self.priceval * 5 / 100)EGP"
        self.commisionval = (self.priceval * 5 / 100)
        if (discount.text != ""){
            discountval = Int(discount.text ?? "0") ?? 0
            discountvalue = (priceval * discountval / 100)
            self.dicountlbl.text = "\(discountvalue) EGP"
        }
     
        totalprice.text = "\(self.priceval + self.commisionval + self.discountvalue) EGP"
    }
    
    @IBAction func discountchange(_ sender: UITextField) {
        if (pricetxt.text! != ""){
            discountval = Int(discount.text ?? "0") ?? 0
            discountvalue = (priceval * discountval / 100)
            self.dicountlbl.text = "\(discountvalue) EGP"
            totalprice.text = "\(self.priceval + self.commisionval + self.discountvalue) EGP"
        }
    }
    
    func validateTextFields() -> Bool {
        pricetxt.customValidationRules = [RequiredRule() ]
        let validator = Validation(textFields: [pricetxt])
        return validator.success
    }
    @IBAction func save(_ sender: Any) {
        if (validateTextFields()){
            isveify = false
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
            isveify = true
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
