//
//  Addcard.swift
//  SupportI
//
//  Created by Adam on 9/23/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import CreditCardValidator

class Addcard: BaseController , UITextFieldDelegate{
    @IBOutlet weak var cardname: UITextField!
    @IBOutlet weak var visanumber: UITextField!
    @IBOutlet weak var visacardname: UILabel!
    @IBOutlet weak var visaexpiry: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var expiry: UITextField!
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    var isedit = false
    var id = 0
    var num = ""
    var expirytxt = ""
    var cardtxt = ""
    var nametxt = ""
    @IBOutlet weak var isdefult: UIButton!
    var isdefultvalue = false

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        number.delegate = self
        expiry.delegate = self
        setup()
        bind()
        if (isedit == true){
            name.text = nametxt
            cardname.text = cardtxt
            number.text = customStringFormatting(of: num, num: 4, ch: " ")
            expiry.text = expirytxt
            visacardname.text = nametxt
            visanumber.text = customStringFormatting(of: num, num: 4, ch: " ")
            visaexpiry.text = expirytxt
            if (isdefultvalue == true){
                isdefult.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
            }else{
                isdefult.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
            }
        }
    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
        isdefult.UIViewAction { [self] in
            if (isdefultvalue == false){
                isdefultvalue = true
                isdefult.setImage(#imageLiteral(resourceName: "Group 11265"), for: .normal)
            }else{
                isdefultvalue = false
                isdefult.setImage(#imageLiteral(resourceName: "radio button-1"), for: .normal)
            }
        }
        
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
                let vcc = self?.pushViewController(Changesuccess.self,storyboard: .profile)
                if (self?.isedit == false){
                    vcc?.txtstring = "Your new card has added".localized()
                }
                vcc?.delegate = self
                self?.pushPop(vcr: vcc!)
        
           
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    @IBAction func save(_ sender: Any) {
    
        if (validateTextFields()){
            var error : String = ""
            if !CreditCardValidator(visanumber.text!).isValid {
                error = "\(error)\n \("Card number is invalid".localized)"
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/yy"
            let enteredDate = dateFormatter.date(from: expiry.text ?? "" ) ?? Date()
            let endOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: enteredDate)!
            let now = Date()
            if (endOfMonth < now) {
                error = "\(error)\n \("Card expiry is invalid".localized)"
            }
            if (error != ""){
              makeAlert(error, closure: {})
            }else{
            parameters["cardName"] = cardname.text ?? ""
            parameters["holderName"] = name.text ?? ""
            parameters["expiry"] = visaexpiry.text ?? ""
            parameters["isDefault"] = isdefultvalue
            parameters["cardNumber"] = visanumber.text?.replacingOccurrences(of: " ", with: "")
            if (isedit == true){
                parameters["id"] = id
                viewModel?.editcard(paramters: parameters)
            }else{
                viewModel?.addcard(paramters: parameters)
            }
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
extension Addcard : ChangesuccessDelegate {
    func settype() {
        self.navigationController?.popViewController()
    }
}
