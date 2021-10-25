//
//  Addproductstep1.swift
//  Wndo
//
//  Created by Adam on 11/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addproductstep1: BaseController {
    
    @IBOutlet weak var sizetablehight: NSLayoutConstraint!
    @IBOutlet weak var savedraft: UIButton!
    @IBOutlet weak var `continue`: UIButton!
    @IBOutlet weak var tags: UITextField!
    @IBOutlet weak var optionhoght: NSLayoutConstraint!
    @IBOutlet weak var options: UITableView!
    @IBOutlet weak var viewoption: UIView!
    var lookups: [Lookup] = []
    var sizes: [SectionItem] = []
    var colors: [SectionItem] = []
    var colorsizes : [ColorsizeModel] = []
    var productid = ""
    var catid = 0
    @IBOutlet weak var sizetable: UITableView!
    var parameters : [String : Any] = [:]
    var viewModel : SallerViewModel?
    var lookmodel : LockupModel?
    let colorsizemodel: ColorsizeModel = ColorsizeModel()
    var colorsizemodel1: ColorsizeModel = ColorsizeModel()

    var productdetails: ProductdetailModel?
    var isperson = false
    var isedit = false
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
    }
    func setup() {
        options.delegate = self
        options.dataSource = self
        sizetable.delegate = self
        sizetable.dataSource = self
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.getlokup(id: catid)
        if (isedit == true){
            savedraft.isHidden = true
            cancel.isHidden = false
            var tagtitle = ""
            for item in productdetails?.responseData?.productTags ?? [] {
                tagtitle = tagtitle + item.tagName! ?? "" + " "
            }
            tags.text = tagtitle
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
                let vcc = self?.pushViewController(Addproductstep2.self,storyboard: .addproduct)
                vcc?.productid = data.responseData?.productId ?? ""
                vcc?.catid = self?.catid ?? 0
                if (self?.isedit == true){
                    vcc?.productdetails = self?.productdetails
                    vcc?.isedit = true
                }
                self?.push(vcc!)
            }
        })
        viewModel?.lookupdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.lookmodel = data
            self?.lookups.removeAll()
            self?.colorsizemodel.issize = data.responseData.isSizes
            self?.colorsizemodel.iscolor = data.responseData.isColors
            self?.colorsizemodel1.issize = data.responseData.isSizes
            self?.colorsizemodel1.iscolor = data.responseData.isColors
            self?.lookups.append(contentsOf: data.responseData.lookups ?? [])
            var jjj = 0
            for item in self?.lookups ?? [] {
                for lookup in self?.productdetails?.responseData?.lookupDtos ?? [] {
                    if item.id == lookup.id {
                        self?.lookups[jjj].chooseid = lookup.lookupValues?[0].id ?? 0
                        self?.lookups[jjj].choosetxt = lookup.lookupValues?[0].displayName ?? ""
                        self?.lookups[jjj].ischoose = true
                    }
                }
                jjj += 1
            }
            if (data.responseData.isColors ) {
                self?.viewModel?.getcolors(id: 1)
            }else {
                if (data.responseData.isSizes ) {
                    self?.viewModel?.getsizes(id: 1)
                }
            }
            if (data.responseData.isColors == false && data.responseData.isSizes == false){
                self?.colorsizes.append((self?.colorsizemodel) as! ColorsizeModel)
                self?.sizetable.reloadData()
            }
           
            self?.options.reloadData()
        })
        viewModel?.sizedata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.sizes.removeAll()
            self?.sizes.append(contentsOf: data.items ?? [])
            self?.colorsizemodel.sizes.append(contentsOf: self!.sizes)
            self?.colorsizemodel1.sizes.append(contentsOf: self!.sizes)

            if (self?.isedit == true){
                for item1 in self?.productdetails?.responseData?.productColorSizes ?? [] {
                    self?.colorsizes.append((self?.colorsizemodel) as! ColorsizeModel)
                }
                var jjj = 0
                for item in self?.colorsizes ?? [] {
//                    for lookup in self?.productdetails?.responseData?.productColorSizes ?? [] {
//                        if item.colorid == lookup.colorID {
//
//                        }
//                        if item.sizeid == lookup.sizeID {
//
//                        }
//
//                    }
                    self?.colorsizes[jjj].sizeid = self?.productdetails?.responseData?.productColorSizes?[jjj].sizeID ?? 0
                    self?.colorsizes[jjj].sizetxt = self?.productdetails?.responseData?.productColorSizes?[jjj].sizeName ?? ""
                    self?.colorsizes[jjj].colorid = self?.productdetails?.responseData?.productColorSizes?[jjj].colorID ?? 0
                    self?.colorsizes[jjj].colortxt = self?.productdetails?.responseData?.productColorSizes?[jjj].colorName ?? ""
                    self?.colorsizes[jjj].quantity = String(self?.productdetails?.responseData?.productColorSizes?[jjj].quantity ?? 0) ?? ""
                    jjj += 1
                }
            }else {
                self?.colorsizes.append((self?.colorsizemodel) as! ColorsizeModel)

            }
            self?.sizetable.reloadData()

        })
        viewModel?.sectiondata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.colors.removeAll()
            self?.colors.append(contentsOf: data.responseData?.items ?? [])
            self?.colorsizemodel.colors.append(contentsOf: self!.colors)
            self?.colorsizemodel1.colors.append(contentsOf: self!.colors)

            if (self?.lookmodel?.responseData.isSizes ?? false ) {
                self?.viewModel?.getsizes(id: 1)
            }else {
                if (self?.isedit == true){
                    for item in self?.productdetails?.responseData?.productColorSizes ?? [] {
                        self?.colorsizes.append((self?.colorsizemodel) as! ColorsizeModel)
                    }
                    var jjj = 0
                    for item in self?.colorsizes ?? [] {
                        for lookup in self?.productdetails?.responseData?.productColorSizes ?? [] {
                            if item.colorid == lookup.colorID {
                                self?.colorsizes[jjj].colorid = lookup.colorID ?? 0
                                self?.colorsizes[jjj].colortxt = lookup.colorName ?? ""
                            }
                            if item.sizeid == lookup.sizeID {
                                self?.colorsizes[jjj].sizeid = lookup.sizeID ?? 0
                                self?.colorsizes[jjj].sizetxt = lookup.sizeName ?? ""
                            }
                            
                        }
                        self?.colorsizes[jjj].quantity = String(self?.productdetails?.responseData?.productColorSizes?[jjj].quantity ?? 0) ?? ""
                        jjj += 1
                    }
                }else {
                    self?.colorsizes.append((self?.colorsizemodel) as! ColorsizeModel)

                }
                self?.sizetable.reloadData()

            }
           
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
  
    @IBAction func savedraft(_ sender: Any) {
        var tagsselect : [String] = []
        tagsselect = tags.text!.findMentionText()
        var error : String = ""
        if tags.text == "" {
            error = "\(error)\n \("field of tags is required".localized)"
        }
        else if tagsselect.count == 0 {
            error = "\(error)\n \("tags is invalid".localized)"
        }
        for item in lookups {
            if (item.ischoose ?? false == false){
                error = "\(error)\n \("Select".localized) \(item.displayName)"

            }
        }
        for item in colorsizes {
            if (item.iscolor == true && item.colorid == 0){
                error = "\(error)\n \("Select Color".localized)"

            }
            if (item.issize == true && item.sizeid == 0){
                error = "\(error)\n \("Select Size".localized)"

            }
            if ( item.quantity == ""){
                error = "\(error)\n \("Select quantity".localized)"

            }
        }
        if (error != ""){
          makeAlert(error, closure: {})
        }else{

            var lookupselect : [Int] = []
            for item in lookups {
                lookupselect.append(item.chooseid ?? 0)
            }
          parameters["lookups"] = lookupselect
            
            parameters["tags"] = tagsselect

           parameters["productId"] = productid
            var sizeselect : [[String: Any]] = []
            for item in colorsizes {
                if (self.lookmodel?.responseData.isSizes == true && self.lookmodel?.responseData.isColors == true){
                    let jsonObject: [String: Any] = [
                        "colorId": item.colorid,
                        "sizeId": item.sizeid,
                        "quantity": Int(item.quantity) ?? 0
                    ]
                    sizeselect.append(jsonObject)
                }else if (self.lookmodel?.responseData.isSizes == false && self.lookmodel?.responseData.isColors == true){
                    let jsonObject: [String: Any] = [
                        "colorId": item.colorid,
                        "quantity": Int(item.quantity) ?? 0
                    ]
                    sizeselect.append(jsonObject)
                }else if (self.lookmodel?.responseData.isSizes == true && self.lookmodel?.responseData.isColors == false){
                    let jsonObject: [String: Any] = [
                        "sizeId": item.sizeid,
                        "quantity": Int(item.quantity) ?? 0
                    ]
                    sizeselect.append(jsonObject)
                }else if (self.lookmodel?.responseData.isSizes == false && self.lookmodel?.responseData.isColors == false){
                    let jsonObject: [String: Any] = [
                        "quantity": Int(item.quantity) ?? 0
                    ]
                    sizeselect.append(jsonObject)
                }
            }
            parameters["colorWithSizeAndQuantity"] = sizeselect

//        parameters["images"] = images
//        parameters["video"] = jsonObject
        print(parameters)
//
////            if (isedit == true){
////                parameters["id"] = id
////                viewModel?.editcard(paramters: parameters)
////            }else{
            viewModel?.addscreen3(paramters: parameters)
        }
    }
    @IBAction func `continue`(_ sender: Any) {
        var tagsselect : [String] = []
        tagsselect = tags.text!.findMentionText()
        var error : String = ""
        if tags.text == "" {
            error = "\(error)\n \("field of tags is required".localized)"
        }
        else if tagsselect.count == 0 {
            error = "\(error)\n \("tags is invalid".localized)"
        }
        for item in lookups {
            if (item.ischoose ?? false == false){
                error = "\(error)\n \("Select".localized) \(item.displayName)"

            }
        }
        for item in colorsizes {
            if (item.iscolor == true && item.colorid == 0){
                error = "\(error)\n \("Select Color".localized)"

            }
            if (item.issize == true && item.sizeid == 0){
                error = "\(error)\n \("Select Size".localized)"

            }
            if ( item.quantity == ""){
                error = "\(error)\n \("Select quantity".localized)"

            }
        }
        if (error != ""){
          makeAlert(error, closure: {})
        }else{

            var lookupselect : [Int] = []
            for item in lookups {
                lookupselect.append(item.chooseid ?? 0)
            }
          parameters["lookups"] = lookupselect
            
            parameters["tags"] = tagsselect

           parameters["productId"] = productid
            var sizeselect : [[String: Any]] = []
            for item in colorsizes {
                if (self.lookmodel?.responseData.isSizes == true && self.lookmodel?.responseData.isColors == true){
                    let jsonObject: [String: Any] = [
                        "colorId": item.colorid,
                        "sizeId": item.sizeid,
                        "quantity": Int(item.quantity) ?? 0
                    ]
                    sizeselect.append(jsonObject)
                }else if (self.lookmodel?.responseData.isSizes == false && self.lookmodel?.responseData.isColors == true){
                    let jsonObject: [String: Any] = [
                        "colorId": item.colorid,
                        "quantity": Int(item.quantity) ?? 0
                    ]
                    sizeselect.append(jsonObject)
                }else if (self.lookmodel?.responseData.isSizes == true && self.lookmodel?.responseData.isColors == false){
                    let jsonObject: [String: Any] = [
                        "sizeId": item.sizeid,
                        "quantity": Int(item.quantity) ?? 0
                    ]
                    sizeselect.append(jsonObject)
                }else if (self.lookmodel?.responseData.isSizes == false && self.lookmodel?.responseData.isColors == false){
                    let jsonObject: [String: Any] = [
                        "quantity": Int(item.quantity) ?? 0
                    ]
                    sizeselect.append(jsonObject)
                }
            }
            parameters["colorWithSizeAndQuantity"] = sizeselect

//        parameters["images"] = images
//        parameters["video"] = jsonObject
        print(parameters)
//
////            if (isedit == true){
////                parameters["id"] = id
////                viewModel?.editcard(paramters: parameters)
////            }else{
            viewModel?.addscreen3(paramters: parameters)
//            }
        }
    }
    
}
extension Addproductstep1:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.options){
            return lookups.count
        }else {
            return colorsizes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.options){
        var cell = tableView.cell(type: LookupTableViewCell.self, indexPath)
        cell.model = lookups[indexPath.row]
        cell.setup()
            optionhoght.constant = CGFloat(lookups.count * 90) + CGFloat(colorsizes.count * 80)
            cell.delegate = self
        return cell
        }else {
            var cell = tableView.cell(type: ColorsizeTableViewCell.self, indexPath)
            cell.model = colorsizes[indexPath.row]
            cell.setup()
            optionhoght.constant = CGFloat(lookups.count * 90) + CGFloat(colorsizes.count * 80)
            sizetablehight.constant = CGFloat(colorsizes.count * 80)
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
   
}
extension Addproductstep1 : PickersPOPDelegate {
    func callbackColor(item: SectionItem, path: Int) {
        colorsizes[path].colorid = item.id ?? 0
        colorsizes[path].colortxt = item.name ?? ""
        sizetable.reloadData()
    }
    func callbackSize(item: SectionItem, path: Int) {
        colorsizes[path].sizeid = item.id ?? 0
        colorsizes[path].sizetxt = item.name ?? ""
        sizetable.reloadData()
    }
    func callbackLookup(item: LookupValue, path: Int) {
        print(path)
        lookups[path].ischoose = true
        lookups[path].chooseid = item.id
        lookups[path].choosetxt = item.displayName
        options.reloadData()
    }
}
extension Addproductstep1 : LookupTableViewCellDelegate , ColorsizeTableViewCellDelegate {
    func setcolor(wasPressedOnCell cell: ColorsizeTableViewCell, path: Int) {
        let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
        vcc.openWhat = "picker"
        vcc.colors = self.colorsizes[path].colors
        vcc.pickerSelection = .color
        vcc.path = path
        vcc.delegate = self
        self.pushPop(vcr: vcc)
    }
    
    func setqunatity(wasPressedOnCell cell: ColorsizeTableViewCell, path: Int, quantity: String) {
        print(path)
        self.colorsizes[path].quantity = quantity ?? ""
        options.reloadData()
    }
    
    func setlookyp(wasPressedOnCell cell: LookupTableViewCell, path: Int) {
        let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
        vcc.openWhat = "picker"
        vcc.lookups = self.lookups[path].lookupValues
        vcc.pickerSelection = .lookup
        vcc.path = path
        vcc.delegate = self
        self.pushPop(vcr: vcc)
    }
    func setsize(wasPressedOnCell cell: ColorsizeTableViewCell, path: Int) {
        let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
        vcc.openWhat = "picker"
        vcc.sizes = self.colorsizes[path].sizes
        vcc.pickerSelection = .size
        vcc.path = path
        vcc.delegate = self
        self.pushPop(vcr: vcc)
    }
    func addrow(wasPressedOnCell cell: ColorsizeTableViewCell, path: Int) {
        print(colorsizemodel.sizeid)
//        colorsizemodel.sizeid = 0
//        colorsizemodel.colorid = 0
//        colorsizemodel.quantity = ""
        self.colorsizes.append((self.colorsizemodel1))
        sizetable.reloadData()
    }
    
    
    
}
extension String {
    func findMentionText() -> [String] {
        var arr_hasStrings:[String] = []
        let regex = try? NSRegularExpression(pattern: "(#[a-zA-Z0-9_\\p{Arabic}\\p{N}]*)", options: [])
        if let matches = regex?.matches(in: self, options:[], range:NSMakeRange(0, self.count)) {
            for match in matches {
                arr_hasStrings.append(NSString(string: self).substring(with: NSRange(location:match.range.location, length: match.range.length )))
            }
        }
        return arr_hasStrings
    }
}
