//
//  Editpassword.swift
//  Wndo
//
//  Created by Adam on 12/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol EditpasswordDelegate: class {
    func settype(type : Bool , pass : String)
}
class Editpassword: BaseController {
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    @IBOutlet weak var repeatpass: UITextField!
    @IBOutlet weak var newpass: UITextField!
    @IBOutlet weak var oldpass: UITextField!
    var delegate : EditpasswordDelegate?
    @IBOutlet weak var oldeye: UIImageView!
    
    @IBOutlet weak var repeateye: UIImageView!
    @IBOutlet weak var neweye: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        
    }
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        oldeye.UIViewAction { [self] in
            if (oldpass.isSecureTextEntry){
                oldpass.isSecureTextEntry = false
                oldeye.image = #imageLiteral(resourceName: "eye Active")
            }else{
                oldpass.isSecureTextEntry = true
                oldeye.image = #imageLiteral(resourceName: "eye")
            }
        }
        neweye.UIViewAction { [self] in
            if (newpass.isSecureTextEntry){
                newpass.isSecureTextEntry = false
                neweye.image = #imageLiteral(resourceName: "eye Active")
            }else{
                newpass.isSecureTextEntry = true
                neweye.image = #imageLiteral(resourceName: "eye")
            }
        }
        repeateye.UIViewAction { [self] in
            if (repeatpass.isSecureTextEntry){
                repeatpass.isSecureTextEntry = false
                repeateye.image = #imageLiteral(resourceName: "eye Active")
            }else{
                repeatpass.isSecureTextEntry = true
                repeateye.image = #imageLiteral(resourceName: "eye")
            }
        }
    }
    override func bind() {
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
        
        viewModel?.editdata.bind({ [weak self](data) in
            self?.stopLoading()
            if (data.responseData?.isValid ?? false){
            self?.delegate?.settype(type: data.responseData?.isValid ?? false, pass: self?.newpass.text ?? "")
            self?.dismiss(animated: true, completion: nil)
            }else {
                self?.makeAlert("Old password is not same", closure: {})

            }
        })
    }
    @IBAction func save(_ sender: Any) {
        if (validateTextFields()){
            var error : String = ""
            if oldpass.text == newpass.text {
                error = "\(error)\n \("New password must not be same old password".localized)"
            }
            if newpass.text != repeatpass.text {
                error = "\(error)\n \("New password must be same reapet password".localized)"
            }
            
            if (error != ""){
              makeAlert(error, closure: {})
            }else{
            parameters["oldPassword"] = oldpass.text ?? ""
            parameters["newPassword"] = newpass.text ?? ""
            viewModel?.editpasswodr(paramters: parameters)
            }
        }
    }
    @IBAction func discard(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func validateTextFields() -> Bool {
       
        oldpass.customValidationRules = [RequiredRule(), MinLengthRule(length: 8),   PasswordRule()]
        newpass.customValidationRules = [RequiredRule(), MinLengthRule(length: 8),  PasswordRule()]
        repeatpass.customValidationRules = [RequiredRule(), MinLengthRule(length: 8),  PasswordRule()]

        let validator = Validation(textFields: [oldpass , newpass ,repeatpass])
        return validator.success
    }
}

