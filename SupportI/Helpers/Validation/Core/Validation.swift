//
//  Validation.swift
//  homeCheif
//
//  Created by mohamed abdo on 4/2/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

class Validation: ValidationDelegate, Alertable {
    public let validator = Validator()
    public var success: Bool = false
    public var message: String = ""

    init(textFields: [UITextField]) {

        for textField in textFields {

            validator.registerField(textField: textField, rules: textField.validator())
            //validator.registerField(textField: textField, rules: rules[textField]!)
            // You can unregister a text field if you no longer want to validate it
            //validator.unregisterField(textField: textField)
        }

        self.initValidator()

    }

    func initValidator() {

        self.validator.styleTransformers(success: { (validationRule) -> Void in
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""

            validationRule.textField.layer.borderColor = nil
            validationRule.textField.layer.borderWidth = 0

            validationRule.errorLabel?.isHidden = false

            //validationRule.textField.underlined(color: Constants.underlineRGB)

            }, error: { (validationError) -> Void in

                if !(validationError.textField.text?.isEmpty)! {
                    let text = validationError.textField.text!
                    self.message += " \n "+text+" "+validationError.errorMessage
                } else if !(validationError.textField.placeholder?.isEmpty)! {
                    let text = validationError.textField.placeholder!
                    self.message += " \n "+text+" "+validationError.errorMessage
                }

//            validationError.errorLabel?.isHidden = false
//            validationError.errorLabel?.text = validationError.errorMessage
//           
//            validationError.textField.underlined(color: UIColor.red)

//                validationError.textField.layer.borderColor = UIColor.red.cgColor
//                validationError.textField.layer.borderWidth = 1.0
//                validationError.textField.setLeftPaddingPoints(CGFloat(5))

        })

        self.validator.validate(delegate: self)

    }

    func validationSuccessful() {
        self.success = true
    }

    func validationFailed(errors: [UITextField: ValidationError]) {
        self.success = false
//        self.showErrors(message: self.message)
        makeAlert(message, closure: {})
    }

//    func showErrors(message:String,indetifier:String = "")  {
//
//        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
//        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
//        let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
//        }
//        alert.addAction(acceptAction)
//
//
//
//    }

}
