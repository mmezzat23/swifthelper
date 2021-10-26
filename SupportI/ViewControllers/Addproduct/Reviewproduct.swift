//
//  Reviewproduct.swift
//  Wndo
//
//  Created by Adam on 19/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import BMPlayer

class Reviewproduct: BaseController {
    @IBOutlet weak var taxes: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var commisionlbl: UILabel!
    @IBOutlet weak var dicountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var buyerprice: UILabel!
    @IBOutlet weak var pricesummary: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var productdep: UILabel!
    @IBOutlet weak var productdes: UILabel!
    @IBOutlet weak var player: BMPlayer!
    @IBOutlet weak var photos: UICollectionView!
    @IBOutlet weak var productinfo: UITableView!
    @IBOutlet weak var colorlbl: UILabel!
    @IBOutlet weak var sizelbl: UILabel!
    
    @IBOutlet weak var productinfohight: NSLayoutConstraint!
    @IBOutlet weak var dateview: UIView!
    @IBOutlet weak var datehight: NSLayoutConstraint!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var pricetxtlbl: UILabel!
    @IBOutlet weak var discountlbl: UILabel!
    @IBOutlet weak var picktimelbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var delivarylbl: UILabel!
    @IBOutlet weak var sizeview: UIView!
    @IBOutlet weak var sizehight: NSLayoutConstraint!
    @IBOutlet weak var sizes: UITableView!
    var productid = ""
    var viewModel : SallerViewModel?
    var parameters : [String : Any] = [:]
    var productdetails: ProductdetailModel?
    var isedit = false
    @IBOutlet weak var discounttxtlbl: UILabel!
    var colorsizes : [ProductColorSize] = []
    var lookups : [LookupDto] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        pricesummary.setunderline(title: "Product Price Summary")
//        9029c51e-f71b-4ecc-b911-8da0e21471aa
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
    }
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        parameters["productId"] = productid
        viewModel?.getproductdetails(paramters: parameters)
        productinfo.delegate = self
        productinfo.dataSource = self
        sizes.delegate = self
        sizes.dataSource = self
        photos.delegate = self
        photos.dataSource = self
    }
    override func bind() {
       
        viewModel?.productdetailsdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.productdetails = data
            self?.productname.text = data.responseData?.name ?? ""
            self?.productdes.text = data.responseData?.responseDataDescription ?? ""
            self?.productdep.text = "\(data.responseData?.section?.name ?? "")/\(data.responseData?.subCategory?.name ?? "")/\(data.responseData?.category?.name ?? "")"
            let asset = BMPlayerResource(url: URL(string: self?.productdetails?.responseData?.videos?[0].urlPreview ?? "")!,
                                                  name: "WNDO")
            self?.player.setVideo(resource: asset)
            var priceval = self?.productdetails?.responseData?.price?.price ?? 0
            var dis = (self?.productdetails?.responseData?.price?.discount)! ?? 0
            var discountval = priceval * dis / 100
            var commisionval = priceval * 5 / 100
            self?.pricelbl.text = "\(self?.productdetails?.responseData?.price?.price ?? 0 ) EGP"
            self?.discounttxtlbl.text = "\(discountval) EGP"
            self?.fees.text = "\(self?.productdetails?.responseData?.price?.shippingFees ?? 0 ) EGP"
            self?.taxes.text = "\(self?.productdetails?.responseData?.price?.taxes ?? 0 ) EGP"
            self?.commisionlbl.text = "\(commisionval) EGP"
            self?.buyerprice.text = "\(priceval + discountval +  commisionval) EGP"
//            self?.pricetxtlbl.text = "\(self?.productdetails?.responseData?.price?.price ) EGP"
            self?.addresslbl.text = self?.productdetails?.responseData?.productShipping?.addressName ?? ""
            if (self?.productdetails?.responseData?.productShipping?.deliveryMethod ?? -1 == 0){
                self?.delivarylbl.text = "ShippingCarrier".localized()
            }else  if (self?.productdetails?.responseData?.productShipping?.deliveryMethod ?? -1 == 1){
                self?.delivarylbl.text = "WndoCarrier".localized()
            }
            if (self?.productdetails?.responseData?.productShipping?.preparationTime ?? -1 == 0){
                self?.timelbl.text = "Immediately".localized()
            }
            if (self?.productdetails?.responseData?.productShipping?.pickUpTime ?? -1 == 0){
                self?.picktimelbl.text = "Any".localized()
            }else  if (self?.productdetails?.responseData?.productShipping?.pickUpTime ?? -1 == 1){
                self?.picktimelbl.text = "Morning 9 am - 2 pm".localized()
            }else  if (self?.productdetails?.responseData?.productShipping?.pickUpTime ?? -1 == 2){
                self?.picktimelbl.text = "Evening 2 pm - 8 pm".localized()
            }
            if (self?.productdetails?.responseData?.price?.discount ?? 0 > 0){
                self?.discountlbl.attributedText = "\(self?.productdetails?.responseData?.price?.price ?? 0) EGP".strikeThrough()
                self?.pricetxtlbl.text = "\(self?.productdetails?.responseData?.price?.priceAfterOffer ?? 0) EGP"
            }else{
                self?.discountlbl.text = ""
                self?.discountlbl.isHidden = true
                self?.self.pricetxtlbl.text = "\(self?.productdetails?.responseData?.price?.price ?? 0) EGP"
            }
            if (data.responseData?.price?.expiryDate ?? "" != ""){
                self?.datelbl.text = data.responseData?.price?.expiryDate ?? ""
            }else {
                self?.datehight.constant = 0
                self?.dateview.isHidden = true
            }
            self?.colorsizes.append(contentsOf: self?.productdetails?.responseData?.productColorSizes ?? [])
            self?.lookups.append(contentsOf: self?.productdetails?.responseData?.lookupDtos ?? [])
            self?.sizes.reloadData()
            self?.photos.reloadData()
            self?.productinfo.reloadData()
            
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
            viewModel?.puplishdata.bind({ [weak self](data) in
                    self?.stopLoading()
                    let vcc = self?.pushViewController(Successsentproduct.self,storyboard: .addproduct)
                    vcc?.txt = "Prouduct is added successfully"
                    self?.push(vcc!)
                
            })
           
    }
    @IBAction func editprice(_ sender: Any) {
        let vcc = self.controller(Addproductstep3.self,storyboard: .addproduct)
        vcc.productdetails = productdetails
        vcc.isedit = true
        vcc.isperson = true
        vcc.productid = productdetails?.responseData?.id ?? ""
        self.push(vcc)
    }
    @IBAction func editship(_ sender: Any) {
        let vcc = self.controller(Addproductstep2.self,storyboard: .addproduct)
        vcc.productdetails = productdetails
        vcc.isedit = true
        vcc.isperson = true
        vcc.productid = productdetails?.responseData?.id ?? ""
        self.push(vcc)
    }
    @IBAction func editinfo(_ sender: Any) {
        let vcc = self.controller(Addproductstep1.self,storyboard: .addproduct)
        vcc.productdetails = productdetails
        vcc.isedit = true
        vcc.isperson = true
        vcc.productid = productdetails?.responseData?.id ?? ""
        self.push(vcc)
    }
    @IBAction func editmedia(_ sender: Any) {
        let vcc = self.controller(Addproductmedia.self,storyboard: .addproduct)
        vcc.productdetails = productdetails
        vcc.isedit = true
        vcc.isperson = true
        vcc.productid = productdetails?.responseData?.id ?? ""
        self.push(vcc)
    }
    @IBAction func editname(_ sender: Any) {
        let vcc = self.controller(Addproduct.self,storyboard: .addproduct)
        vcc.productdetails = productdetails
        vcc.isedit = true
        vcc.isperson = true
        self.push(vcc)
    }
    
    @IBAction func edit(_ sender: Any) {
        let vcc = self.controller(Addproduct.self,storyboard: .addproduct)
        vcc.productdetails = productdetails
        vcc.isedit = true
        self.push(vcc)
    }
    @IBAction func post(_ sender: Any) {
        self.viewModel?.puplishproducr(id: self.productid ?? "")
    }
    
}
extension Reviewproduct:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.productinfo){
            return self.lookups.count
        }else {
            return self.colorsizes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.productinfo){
        var cell = tableView.cell(type: LookupshowTableViewCell.self, indexPath)
        cell.model = self.lookups[indexPath.row]
        cell.setup()
            productinfohight.constant = CGFloat(lookups.count * 40)
        return cell
        }else {
            var cell = tableView.cell(type: SizecolorselectTableViewCell.self, indexPath)
            cell.model = self.colorsizes[indexPath.row]
            cell.setup()
            sizehight.constant = CGFloat(self.colorsizes.count * 40 + 90)
        
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
   
}
extension Reviewproduct: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:  102 , height: self.photos.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productdetails?.responseData?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.cell(type: imagesshowCollectionViewCell.self, indexPath)
        cell.model = productdetails?.responseData?.images?[safe: indexPath.row]
        cell.setup()
        return cell
    }
    
}
                                           
     extension String {
         func strikeThrough() -> NSAttributedString {
                         let attributeString =  NSMutableAttributedString(string: self)
                   attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
                   return attributeString
        }
    }
