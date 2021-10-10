//
//  Editemail.swift
//  Wndo
//
//  Created by Adam on 10/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol EditemailDelegate: class {
    func settype(type : String)
}
class Editemail: BaseController {
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var input: UITextField!
    var cities : [ItemCity] = []
    var cityid = 0
    var responseData: Token?
    var type = ""
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    var delegate : EditemailDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        if (type == "email"){
            input.keyboardType = .emailAddress
            input.text = responseData?.email
            input.placeholder = "Enter your new mail".localized()
            namelbl.text = "Edit E-Mail".localized()
        }else  if (type == "phone"){
            input.keyboardType = .phonePad
            input.text = responseData?.phone
            input.placeholder = "Enter your new phone number".localized()
            namelbl.text = "Edit phone number".localized()
        }else{
            input.text = responseData?.city?.name
            cityid = responseData?.city?.id ?? 0
            namelbl.text = "Edit city".localized()
        }
    }
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        input.UIViewAction { [self] in
            if (type == "loc"){
                let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
                vcc.openWhat = "picker"
                vcc.cities = cities
                vcc.pickerSelection = .city
                vcc.delegate = self
                pushPop(vcr: vcc)
            }
        }
    }
    override func bind() {
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
        viewModel?.cityData.bind({ [weak self](data) in
            self?.stopLoading()
            self?.cities.append(contentsOf: data.responseData?.items ?? [])
            
        })
        viewModel?.verifyphone.bind({ [weak self](data) in
            self?.stopLoading()
            self?.makeAlert(data.responseData ?? "", closure: { [self] in
                self?.delegate?.settype(type: self!.type)
                self?.dismiss(animated: true, completion: nil)
            })
        })
        viewModel?.editdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.delegate?.settype(type: self!.type)
            self?.dismiss(animated: true, completion: nil)
        })
    }
    @IBAction func save(_ sender: Any) {
        if (validateTextFields()){
            if (type == "email"){
                if (input.text == responseData?.email){
                    self.dismiss(animated: true, completion: nil)
                }else{
                    parameters["email"] = input.text
                    viewModel?.verfiyaccountsetting(phone: self.input.text ?? "")
                }
            }else  if (type == "phone"){
                if (input.text == responseData?.phone){
                    self.dismiss(animated: true, completion: nil)
                }else{
                    parameters["phone"] = input.text
                    viewModel?.verfiyaccountsetting(phone: self.input.text ?? "")
                }
            }else{
                if (cityid == responseData?.city?.id){
                    self.dismiss(animated: true, completion: nil)
                }else{
                    parameters["cityId"] = cityid
                    viewModel?.editaccountsetting(paramters: parameters)
                }
            }
        }
    }
    @IBAction func discrd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func validateTextFields() -> Bool {
        if (type == "phone") {
            input.customValidationRules = [RequiredRule() , PhoneNumberRule()]
        }else if (type == "email") {
            input.customValidationRules = [RequiredRule() , EmailRule()]
        }
        let validator = Validation(textFields: [input])
        return validator.success
    }
}
extension Editemail : PickersPOPDelegate {
    func callbackCity(item: ItemCity) {
        cityid = item.id ?? 0
        input.text = item.name ?? ""
    }
   
}
