//
//  Passworddelete.swift
//  SupportI
//
//  Created by Adam on 9/30/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Passworddelete: BaseController {
    @IBOutlet weak var password: UITextField!
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()

        // Do any additional setup after loading the view.
    }
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
    }
    override func bind() {
        viewModel?.deletedata.bind({ [weak self](data) in
            self?.stopLoading()
            UserRoot.save(response: Data())
            self?.dismiss(animated: true, completion: nil)
            let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
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
    func validateTextFields() -> Bool {
       
           password.customValidationRules = [RequiredRule()]
           let validator = Validation(textFields: [password])
           return validator.success
       }
    @IBAction func yes(_ sender: Any) {
        if (validateTextFields()){
            parameters["OnTimePassword"] = password.text
            viewModel?.deleteaccountconfirm(paramters: parameters)
        }
    }
    @IBAction func discard(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
