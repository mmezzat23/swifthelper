//
//  Addproduct.swift
//  Wndo
//
//  Created by Adam on 11/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addproduct: BaseController {

    @IBOutlet weak var subcattxt: UILabel!
    @IBOutlet weak var subcat: UIView!
    @IBOutlet weak var cattxt: UILabel!
    @IBOutlet weak var catogary: UIView!
    @IBOutlet weak var sectxt: UILabel!
    @IBOutlet weak var section: UIView!
    @IBOutlet weak var productdescription: UITextField!
    @IBOutlet weak var productname: UITextField!
    var sections : [SectionItem] = []
    var cats : [SectionItem] = []
    var subcats : [SectionItem] = []
    var sec_id = 0
    var cat_id = 0
    var subcat_id = 0
    var viewModel : SallerViewModel?
    var parameters : [String : Any] = [:]
    var productdetails: ProductdetailModel?
    var isperson = false
    var isedit = false
    @IBOutlet weak var save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        onclick()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
       viewModel?.getsection()
        if (isedit == true){
            cat_id = productdetails?.responseData?.category?.id ?? 0
            subcat_id = productdetails?.responseData?.subCategory?.id ?? 0
            sec_id = productdetails?.responseData?.section?.id ?? 0
            cattxt.text = productdetails?.responseData?.category?.name ?? ""
            subcattxt.text = productdetails?.responseData?.subCategory?.name ?? ""
            sectxt.text = productdetails?.responseData?.section?.name ?? ""
            productname.text = productdetails?.responseData?.name ?? ""
            productdescription.text = productdetails?.responseData?.responseDataDescription ?? ""
            sectxt.textColor = UIColor(red: 1, green: 20, blue: 71)
            cattxt.textColor = UIColor(red: 1, green: 20, blue: 71)
            subcattxt.textColor = UIColor(red: 1, green: 20, blue: 71)


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
                let vcc = self?.pushViewController(Addproductmedia.self,storyboard: .addproduct)
                vcc?.productid = data.responseData?.productId ?? ""
                vcc?.catid = self?.subcat_id ?? 0
                if (self?.isedit == true){
                    vcc?.productdetails = self?.productdetails
                    vcc?.isedit = true
                }
                self?.push(vcc!)
            }
        })
        viewModel?.sectiondata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.sections.removeAll()
            self?.sections.append(contentsOf: data.responseData?.items ?? [])
           
        })
        viewModel?.catdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.cats.removeAll()
            self?.cats.append(contentsOf: data.responseData?.items ?? [])
            self?.subcats.removeAll()
            self?.cat_id = 0
            self?.subcat_id = 0
            self?.cattxt.text = "Select category".localized()
            self?.subcattxt.text = "Select subcategory".localized()

           
        })
        viewModel?.subcatdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.subcats.removeAll()
            self?.subcats.append(contentsOf: data.responseData?.items ?? [])
            self?.subcat_id = 0
            self?.subcattxt.text = "Select subcategory".localized()

           
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    func onclick() {
        section.UIViewAction {  [self] in
                let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
                vcc.openWhat = "picker"
                vcc.sections = self.sections
                vcc.pickerSelection = .section
                vcc.delegate = self
                self.pushPop(vcr: vcc)
            
        }
        catogary.UIViewAction { [self] in
            if (sec_id > 0){
                let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
                vcc.openWhat = "picker"
                vcc.cats = self.cats
                vcc.pickerSelection = .category
                vcc.delegate = self
                self.pushPop(vcr: vcc)
            }else {
                self.makeAlert("Select section".localized(), closure: {})
            }
            
        }
        subcat.UIViewAction { [self] in
            if (cat_id > 0){
                let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
                vcc.openWhat = "picker"
                vcc.subcats = self.subcats
                vcc.pickerSelection = .subcat
                vcc.delegate = self
                self.pushPop(vcr: vcc)
            }else {
                self.makeAlert("Select section".localized(), closure: {})
            }
            
        }
    }
    func validateTextFields() -> Bool {
        productname.customValidationRules = [RequiredRule() , MaxLengthRule(length: 16)]
        productdescription.customValidationRules = [RequiredRule(), MaxLengthRule(length: 100)]
        let validator = Validation(textFields: [productname , productdescription])
        return validator.success
    }
    
    @IBAction func `continue`(_ sender: Any) {
        if (validateTextFields()){
            var error : String = ""
            if sec_id == 0 {
                error = "\(error)\n \("Select section".localized)"
            }
            if cat_id == 0 {
                error = "\(error)\n \("Select category".localized)"
            }
            if subcat_id == 0 {
                error = "\(error)\n \("Select subcategory".localized)"
            }
            if (error != ""){
              makeAlert(error, closure: {})
            }else{
            parameters["name"] = productname.text ?? ""
            parameters["description"] = productdescription.text ?? ""
            parameters["sectionId"] = sec_id
            parameters["categoryId"] = cat_id
            parameters["subCategoryId"] = subcat_id
                if (isedit == true){
                    parameters["productId"] = productdetails?.responseData?.id ?? 0
                }
//            if (isedit == true){
//                parameters["id"] = id
//                viewModel?.editcard(paramters: parameters)
//            }else{
                viewModel?.addscreen1(paramters: parameters)
//            }
            }
        }
    }
}
extension Addproduct : PickersPOPDelegate {
    
    func callbacksection(item: SectionItem) {
        sec_id = item.id ?? 0
        sectxt.text = item.name ?? ""
        viewModel?.getcats(id: sec_id)
        sectxt.textColor = UIColor(red: 1, green: 20, blue: 71)
        cattxt.textColor = UIColor(red: 150, green: 161, blue: 171)
        subcattxt.textColor = UIColor(red: 150, green: 161, blue: 171)

    }
    func callbacksubcat(item: SectionItem) {
        subcat_id = item.id ?? 0
        subcattxt.text = item.name ?? ""
        subcattxt.textColor = UIColor(red: 1, green: 20, blue: 71)

    }
    func callbackCategory(item: SectionItem) {
        cat_id = item.id ?? 0
        cattxt.text = item.name ?? ""
        viewModel?.getsubcats(id: cat_id)
        cattxt.textColor = UIColor(red: 1, green: 20, blue: 71)
        subcattxt.textColor = UIColor(red: 150, green: 161, blue: 171)
    }
}
