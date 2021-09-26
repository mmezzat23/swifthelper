//
//  Addcard.swift
//  SupportI
//
//  Created by Adam on 9/23/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import FormTextField

class Addcard: BaseController , UITextFieldDelegate{
    @IBOutlet weak var cardname: UITextField!
    @IBOutlet weak var visanumber: UITextField!
    @IBOutlet weak var visacardname: UILabel!
    @IBOutlet weak var visaexpiry: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: FormTextField!
    @IBOutlet weak var expiry: FormTextField!
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    var isedit = false
    var id = 0
    var num = ""
    var expirytxt = ""
    var nametxt = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        number.delegate = self
        expiry.delegate = self
        setup()
        bind()
        if (isedit == true){
            name.text = nametxt
            number.text = num
            expiry.text = expirytxt
            visacardname.text = nametxt
            visanumber.text = num
            visaexpiry.text = expirytxt
        }
    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
   }
    func validateTextFields() -> Bool {
        cardname.customValidationRules = [RequiredRule()]
        name.customValidationRules = [RequiredRule()]
        number.customValidationRules = [RequiredRule() , MinLengthRule(length: 19) , MaxLengthRule(length: 19)]
        expiry.customValidationRules = [RequiredRule() , MinLengthRule(length: 5) , MaxLengthRule(length: 5)]
        let validator = Validation(textFields: [name , number ,expiry , cardname])
        return validator.success
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                   guard let nav = controller else { return }
                   let delegate = UIApplication.shared.delegate as? AppDelegate
                   delegate?.window?.rootViewController = nav
           
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    @IBAction func save(_ sender: Any) {
        if (validateTextFields()){
            parameters["holderName"] = name.text ?? ""
            parameters["expiry"] = visaexpiry.text ?? ""
            parameters["cardNumber"] = visanumber.text?.trim() ?? ""
            if (isedit == true){
                parameters["id"] = id
                viewModel?.editcard(paramters: parameters)
            }else{
                viewModel?.addcard(paramters: parameters)
            }
            print(parameters)
        }
    }
    
    @IBAction func expirychange(_ sender: Any) {
        visaexpiry.text = customStringFormatting(of: expiry.text ?? "", num: 2, ch: "/")
    }
    
    @IBAction func namechange(_ sender: Any) {
        visacardname.text = name.text
    }
    
    @IBAction func numberchange(_ sender: Any) {
        var numb = number.text?.trim() ?? ""
//        number.text = customStringFormatting(of: numb, num: 4, ch: " ")
        visanumber.text = customStringFormatting(of: numb, num: 4, ch: " ")
    }
    
    func customStringFormatting(of str: String , num : Int , ch : String) -> String {
        return str.characters.chunk(n: num)
            .map{ String($0) }.joined(separator: ch)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // only allow numerical characters
        guard string.characters.flatMap({ Int(String($0)) }).count ==
            string.characters.count else { return false }

        let text = textField.text ?? ""
        if (textField == number){
            if string.characters.count == 0 {
                textField.text = String(text.characters.dropLast()).chunkFormatted()
                visanumber.text = String(text.characters.dropLast()).chunkFormatted()
            }
            else {
                let newText = String((text + string).characters
                    .filter({ $0 != " " }).prefix(16))
                textField.text = newText.chunkFormatted()
                visanumber.text = newText.chunkFormatted()
            }
        }else if (textField == expiry){
            if string.characters.count == 0 {
                textField.text = String(text.characters.dropLast()).chunkFormattedexpiry()
                visaexpiry.text = String(text.characters.dropLast()).chunkFormattedexpiry()
            }
            else {
                let newText = String((text + string).characters
                    .filter({ $0 != "/" }).prefix(4))
                textField.text = newText.chunkFormattedexpiry()
                visaexpiry.text = newText.chunkFormattedexpiry()
            }
        }
        return false
    }

}


extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
extension String {
    func chunkFormatted(withChunkSize chunkSize: Int = 4,
        withSeparator separator: Character = " ") -> String {
        return characters.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
    }
    func chunkFormattedexpiry(withChunkSize chunkSize: Int = 2,
        withSeparator separator: Character = "/") -> String {
        return characters.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
    }
}
