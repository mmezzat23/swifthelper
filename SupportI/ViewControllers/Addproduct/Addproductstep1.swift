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
        viewModel?.getlokup(id: 1)
    }

    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
                self?.stopLoading()
                let vcc = self?.pushViewController(Addproductstep2.self,storyboard: .addproduct)
                vcc?.productid = data.responseData?.productId ?? ""
                vcc?.catid = self?.catid ?? 0
                self?.push(vcc!)
        })
        viewModel?.lookupdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.lookmodel = data
            self?.lookups.removeAll()
            self?.colorsizemodel.issize = data.responseData.isSizes
            self?.colorsizemodel.iscolor = data.responseData.isColors

            self?.lookups.append(contentsOf: data.responseData.lookups ?? [])
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
            self?.colorsizes.append((self?.colorsizemodel) as! ColorsizeModel)
            self?.sizetable.reloadData()

        })
        viewModel?.sectiondata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.colors.removeAll()
            self?.colors.append(contentsOf: data.responseData?.items ?? [])
            self?.colorsizemodel.colors.append(contentsOf: self!.colors)
            if (self?.lookmodel?.responseData.isSizes ?? false ) {
                self?.viewModel?.getsizes(id: 1)
            }else {
                self?.colorsizes.append((self?.colorsizemodel) as! ColorsizeModel)
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
    }
    @IBAction func `continue`(_ sender: Any) {
        var error : String = ""
        if tags.text == "" {
            error = "\(error)\n \("field of tags is required".localized)"
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
            var tagsselect : [String] = []
            tagsselect.append("#test")
            parameters["tags"] = tagsselect

           parameters["productId"] = "68d372bc-8e2d-46cf-ab3d-7c8607c9e1bb"
            var sizeselect : [[String: Any]] = []
            for item in colorsizes {
                let jsonObject: [String: Any] = [
                    "colorId": item.colorid,
                    "quantity": Int(item.quantity)
                ]
                sizeselect.append(jsonObject)
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
            optionhoght.constant = CGFloat(lookups.count * 90) + CGFloat(colorsizes.count * 75)
            cell.delegate = self
        return cell
        }else {
            var cell = tableView.cell(type: ColorsizeTableViewCell.self, indexPath)
            cell.model = colorsizes[indexPath.row]
            cell.setup()
            optionhoght.constant = CGFloat(lookups.count * 90) + CGFloat(colorsizes.count * 75)
            sizetablehight.constant = CGFloat(colorsizes.count * 75)
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
        self.colorsizes[path].quantity = quantity
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
    
    
    
}
