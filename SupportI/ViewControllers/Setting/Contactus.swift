//
//  Contactus.swift
//  SupportI
//
//  Created by Adam on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Contactus: BaseController {

    @IBOutlet weak var orderlbl: UILabel!
    @IBOutlet weak var reasonlbl: UILabel!
    @IBOutlet weak var orderconstant: NSLayoutConstraint!
    @IBOutlet weak var phoneconstant: NSLayoutConstraint!
    @IBOutlet weak var emailcostant: NSLayoutConstraint!
    @IBOutlet weak var phonetxthight: NSLayoutConstraint!
    @IBOutlet weak var emailtxthight: NSLayoutConstraint!
    @IBOutlet weak var ordertxthight: NSLayoutConstraint!
    @IBOutlet weak var reasontxthight: NSLayoutConstraint!
    @IBOutlet weak var messagetxt: UILabel!
    @IBOutlet weak var contact: UIView!
    @IBOutlet weak var phonetxt: UILabel!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var phonehight: NSLayoutConstraint!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var emailtxt: UILabel!
    @IBOutlet weak var emailhight: NSLayoutConstraint!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var ordertxt: UILabel!
    @IBOutlet weak var reasontxt: UILabel!
    @IBOutlet weak var orderhight: NSLayoutConstraint!
    @IBOutlet weak var order: UIView!
    @IBOutlet weak var reasonhight: NSLayoutConstraint!
    @IBOutlet weak var reason: UIView!
    @IBOutlet weak var reasontop: NSLayoutConstraint!
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    var reasons : [ResponseDatum] = []
    var reasonid = 0
    var orderid = 0
    @IBOutlet var banner: UIView!
    
    @IBOutlet weak var notify: UIButton!
    @IBOutlet weak var or: UILabel!
    @IBOutlet weak var custmerphone: UILabel!
    @IBOutlet weak var call: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        if (UserRoot.saller() == true){
            banner.backgroundColor = UIColor(red: 01, green: 14, blue: 47)
            notify.setImage(#imageLiteral(resourceName: "notify"), for: .normal)
        }
        if (UserRoot.token() != nil) {
            if (UserRoot.saller() == true){
            viewModel?.getreasons(type: "0")
            }else{
                viewModel?.getreasons(type: "1")
            }
            viewModel?.getaccountsetting()
        }else{
            order.isHidden = true
            reason.isHidden = true
            ordertxt.isHidden = true
            reasontxt.isHidden = true
            orderhight.constant = 0
            reasonhight.constant = 0
            ordertxthight.constant = 0
            reasontxthight.constant = 0
            orderconstant.constant = 0
            reasontop.constant = 0
        }
        or.setunderline(title: "OR")
        call.UIViewAction { [self] in
            if (custmerphone.text != "") {
                Wndo.call(text: custmerphone.text)
            }
        }
    }
    
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
        viewModel?.getcontact()
        reason.UIViewAction {
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.raesons = self.reasons
            vcc.pickerSelection = .raeson
            vcc.delegate = self
            self.pushPop(vcr: vcc)
        }
        contact.UIViewAction { [self] in
            if (validateTextFields()){
                if (UserRoot.token() != nil){
                    var error : String = ""
                    if (reasonid == 0){
                        error = "\(error)\n \("select reason".localized)"
                    }
                    if (error != ""){
                      makeAlert(error, closure: {})
                    }else{
                        parameters["reasonId"] = reasonid
                        parameters["orderId"] = orderid
                        parameters["email"] = email.text
                        parameters["phone"] = phone.text
                        parameters["message"] = message.text
                        viewModel?.contactus(paramters: parameters)
                    }
                }else{
                    parameters["email"] = email.text
                    parameters["phone"] = phone.text
                    parameters["message"] = message.text
                    viewModel?.contactus(paramters: parameters)
                }
            }
        }
   }
    
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.email.text = data.responseData?.email
            self?.phone.text = data.responseData?.phone
        })
        viewModel?.reasons.bind({ [weak self](data) in
            self?.stopLoading()
            self?.reasons.append(contentsOf: data.responseData ?? [])
           
        })
        viewModel?.socialdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.custmerphone.text = data.responseData?.number ?? ""
           
        })
        viewModel?.deletedata.bind({ [weak self](data) in
            self?.stopLoading()
            if (UserRoot.saller() == true){
                let controller = UIStoryboard(name: "Saller", bundle: nil).instantiateInitialViewController()
                       guard let nav = controller else { return }
                       let delegate = UIApplication.shared.delegate as? AppDelegate
                       delegate?.window?.rootViewController = nav
            }else{
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                       guard let nav = controller else { return }
                       let delegate = UIApplication.shared.delegate as? AppDelegate
                       delegate?.window?.rootViewController = nav
            }
           
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    func validateTextFields() -> Bool {
       
           message.customValidationRules = [RequiredRule()]
//           if (UserRoot.token() == nil){
//            email.customValidationRules = [RequiredRule() , EmailRule()]
//            phone.customValidationRules = [RequiredRule() , PhoneNumberRule()]
//           }
           let validator = Validation(textFields: [message,phone , email])
           return validator.success
       }
}

extension Contactus : PickersPOPDelegate {
    func callbackreasons(item: ResponseDatum) {
        reasonlbl.text = item.name
        reasonid = item.id ?? 0
    }
}
