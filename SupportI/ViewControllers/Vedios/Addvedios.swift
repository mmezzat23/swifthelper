//
//  Addvedio.swift
//  Wndo
//
//  Created by Adam on 12/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addvedios: BaseController {
    @IBOutlet weak var vediolbl: UITextField!
    @IBOutlet weak var vediodes: UITextField!
    
    @IBOutlet weak var tags: UITextField!
    @IBOutlet weak var selectvedio: UILabel!
    @IBOutlet weak var product: UIView!
    var productid = ""
    var products : [ProductsResponseDatum] = []
    var viewModel : SallerViewModel?
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
        viewModel?.getproducts()
        product.UIViewAction {
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.products = self.products
            vcc.pickerSelection = .product
            vcc.delegate = self
            self.pushPop(vcr: vcc)
        }
        
    }
    override func bind() {
       
        viewModel?.productssdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.products.removeAll()
            self?.products.append(contentsOf: data.responseData ?? [])
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
           
    }
    func validateTextFields() -> Bool {
        vediolbl.customValidationRules = [RequiredRule() , MaxLengthRule(length: 16)]
        vediodes.customValidationRules = [RequiredRule(), MaxLengthRule(length: 100)]
        let validator = Validation(textFields: [vediolbl , vediodes])
        return validator.success
    }
    @IBAction func `continue`(_ sender: Any) {
        if (validateTextFields()) {
            var tagsselect : [String] = []
            tagsselect = tags.text!.findMentionText()
            var error : String = ""
            if tags.text == "" {
                error = "\(error)\n \("field of tags is required".localized)"
            }
            else if tagsselect.count == 0 {
                error = "\(error)\n \("tags is invalid".localized)"
            }
            if (productid == ""){
                error = "\(error)\n \("Select the product".localized)"

            }
            if (error != ""){
              makeAlert(error, closure: {})
            }else{
                parameters["name"] = vediolbl.text
                parameters["description"] = vediodes.text
                parameters["tags"] = tagsselect
                parameters["productId"] = productid
                let vcc = self.controller(Vedioattachorrecord.self,storyboard: .vedios)
                vcc.parameters = self.parameters
                self.push(vcc)
            }
        }
    }
    

    @IBAction func address(_ sender: Any) {
    }
}
extension Addvedios : PickersPOPDelegate {
    func callbackproducts(item: ProductsResponseDatum) {
        productid = item.id ?? ""
        selectvedio.text = item.name ?? ""
        
    }
}
