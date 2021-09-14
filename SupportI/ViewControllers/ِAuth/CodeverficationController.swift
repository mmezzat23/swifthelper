//
//  CodeverficationController.swift
//  SupportI
//
//  Created by Adam on 9/13/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class CodeverficationController: BaseController , UITextFieldDelegate{
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var code1: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code4: UITextField!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var resend: UILabel!
    var isCommingFromForgetPassword = false
    var code = ""
    var timerHelper: TimeHelper?
    var viewModel : Auth1ViewModel?
    var parameters : [String : Any] = [:]
    var userName : String = ""
    var sendTo : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        self.phone.text = "We sent your code to".localized + " " + sendTo
        setup()
        bind()
        code1.delegate = self
        code2.delegate = self
        code3.delegate = self
        code4.delegate = self
        code1.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        code2.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        code3.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        code4.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        timerHelper = .init(seconds: 1, numberOfCycle: 120, closure: { [weak self] (cycle) in
            if cycle >= 60 {
                self?.time.text = "01:\(cycle-60)"
            } else {
                self?.time.text = "00:\(cycle)"
            }
            if cycle == 0 {
                self?.time.isHidden = true
            }
        })
    }
    
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
          // GO TO LOGIN
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
   }
    @IBAction func confirm(_ sender: Any) {
        self.verifyOtpApi()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        code = ""
        if (getAppLang() == "ar" ){
            if (code4.text != ""){
                code += (code4.text ?? "")
                if (code3.text != ""){
                    code += (code3.text ?? "")
                    if (code2.text != ""){
                        code += (code2.text ?? "")
                        if (code1.text != ""){
                            code += (code1.text ?? "")
                            print(code,"code")
                        }
                    }
                }
                
            }
            if textField == code4 {
                if (textField.text?.count)! >= 1 {
                    code3?.becomeFirstResponder()
                }
            }
            else if textField == code3 {
                if (textField.text?.count)! >= 1 {
                    code2.becomeFirstResponder()
                } else {
                    code4.becomeFirstResponder()
                }
            }
            else if textField == code2 {
                if (textField.text?.count)! >= 1 {
                    code1.becomeFirstResponder()
                }  else {
                    code3.becomeFirstResponder()
                }
            } else if textField == code1 {
                if (textField.text?.count)! < 1 {
                    code2.becomeFirstResponder()
                }
            }
        }
        else
        {
            
            if (code4.text != "")
            {
                if (code1.text != "")
                {
                    code += (code1.text ?? "")
                    if (code2.text != "")
                    {
                        code += (code2.text ?? "")
                        if (code3.text != "")
                        {
                            code += (code3.text ?? "")
                            if (code4.text != "")
                            {
                                code += (code4.text ?? "")
                            }
                            
                        }
                    }
                }
                
            }
            
            if textField == code1 {
                if (textField.text?.count)! >= 1 {
                    code2?.becomeFirstResponder()
                }
            }
            else if textField == code2 {
                if (textField.text?.count)! >= 1 {
                    code3.becomeFirstResponder()
                } else {
                    code1.becomeFirstResponder()
                }
            }
            else if textField == code3 {
                if (textField.text?.count)! >= 1 {
                    code4.becomeFirstResponder()
                } else {
                    code2.becomeFirstResponder()
                }
            } else if textField == code4 {
                if (textField.text?.count)! < 1 {
                    code3.becomeFirstResponder()
                }
            }
        }
        
        print(textField.text , "Change")
    }
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxCharacters = 1
        // Handle backspace/delete
        guard !string.isEmpty else {
            
            // Backspace detected, allow text change, no need to process the text any further
            return true
        }
        
        
        
        // Length Processing
        // Need to convert the NSRange to a Swift-appropriate type
        if let text = textField.text, let range = Range(range, in: text) {
            
            let proposedText = text.replacingCharacters(in: range, with: string)
            
            // Check proposed text length does not exceed max character count
            guard proposedText.count <= maxCharacters else {
                
                // Present alert if pasting text
                // easy: pasted data has a length greater than 1; who copy/pastes one character?
                if string.count > 1 {
                    
                    // Pasting text, present alert so the user knows what went wrong
                    //   presentAlert("Paste failed: Maximum character count exceeded.")
                }
                
                // Character count exceeded, disallow text change
                return false
            }
            
            // Only enable the OK/submit button if they have entered all numbers for the last four
            // of their SSN (prevents early submissions/trips to authentication server, etc)
            //  answerButton.isEnabled = (proposedText.count == 4)
        }
        if textField == code4 || textField == code3 || textField == code2 || textField == code1 {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        // Allow text change
        return true
    }
    
    
    func verifyOtpApi() {
        parameters["userName"] = self.userName
        parameters["code"] = self.code
        print("coddeeeee\(self.code)")
         if isCommingFromForgetPassword {
          viewModel?.VerifyOtpApi(paramters: parameters , url: .verifyForgetPasswordOTP)
        } else {
          viewModel?.VerifyOtpApi(paramters: parameters , url: .verifyRegisterationOTP)
        }
    }
}
