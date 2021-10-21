//
//  Addproductstep2.swift
//  Wndo
//
//  Created by Adam on 11/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addproductstep2: BaseController {
    @IBOutlet weak var delivarymethod: UITextField!
    @IBOutlet weak var address: UIView!
    @IBOutlet weak var imgaddress: UIImageView!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var time: UIView!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var times: UICollectionView!
    var productid = ""
    var catid = 0
    var addressid = 0
    var protimeid = -1
    var delivaryid = -1
    var delevariymethods : [GenderModel] = []
    var protimes : [GenderModel] = []
    var addressdata : [ItemAddress] = []
    var pickuptimes : [GenderModel] = []
    var parameters : [String : Any] = [:]
    var sallermodel : SallerViewModel?
    var viewModel : ProfileViewModel?
    var pickid = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        onclick()
    }
    func setup() {
        times.delegate = self
        times.dataSource = self
        self.delevariymethods.removeAll()
        self.delevariymethods.append(GenderModel(type: "0", name: "ShippingCarrier".localized()))
        self.delevariymethods.append(GenderModel(type: "1", name: "WndoCarrier".localized()))
        self.protimes.removeAll()
        self.protimes.append(GenderModel(type: "0", name: "Immediately".localized()))
        self.pickuptimes.removeAll()
        self.pickuptimes.append(GenderModel(type: "0", name: "Any".localized()))
        self.pickuptimes.append(GenderModel(type: "1", name: "Morning 9 am - 2 pm".localized()))
        self.pickuptimes.append(GenderModel(type: "2", name: "Evening 2 pm - 8 pm".localized()))
        viewModel = .init()
        viewModel?.delegate = self
        sallermodel = .init()
        sallermodel?.delegate = self
        viewModel?.getaddresss()
    }
    override func bind() {
        viewModel?.addressData.bind({ [weak self](data) in
            self?.stopLoading()
            self?.addressdata.append(contentsOf: data.responseData?.items ?? [])
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
        viewModel?.userdata.bind({ [weak self](data) in
                self?.stopLoading()
                let vcc = self?.pushViewController(Addproductstep3.self,storyboard: .addproduct)
                vcc?.productid = data.responseData?.productId ?? ""
                self?.push(vcc!)
        })
    }
    func onclick () {
        delivarymethod.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.delevariymethods = delevariymethods
            vcc.pickerSelection = .delivary
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        time.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.protimes = protimes
            vcc.pickerSelection = .time
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        address.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.addressdata = addressdata
            vcc.pickerSelection = .address
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
    }
    @IBAction func addnewaddress(_ sender: Any) {
        let vcc = self.pushViewController(Addaddress.self,storyboard: .profile)
        vcc.delegate = self
        vcc.ispop = true
        self.pushPop(vcr: vcc)
    }
    @IBAction func `continue`(_ sender: Any) {
        var error : String = ""
        if addressid == 0 {
            error = "\(error)\n \("select address".localized)"
        }
        if protimeid == -1 {
            error = "\(error)\n \("select Preparation Time".localized)"
        }
        if delivaryid == -1 {
            error = "\(error)\n \("select Delivery Method".localized)"
        }
        if pickid == -1 {
            error = "\(error)\n \("select Pickup Time".localized)"
        }
        if (error != ""){
          makeAlert(error, closure: {})
        }else{

           parameters["productId"] = productid
            parameters["deliveryMethod"] = delivaryid
            parameters["pickUpTime"] = pickid
            parameters["addressId"] = addressid
            parameters["preparationTime"] = protimeid

        print(parameters)
//
////            if (isedit == true){
////                parameters["id"] = id
////                viewModel?.editcard(paramters: parameters)
////            }else{
            sallermodel?.addscreen4(paramters: parameters)
//            }
        }
    }
    @IBAction func savedraft(_ sender: Any) {
    }
    
}
extension Addproductstep2 : PickersPOPDelegate , AddaddressDelegate {
    func callbackaddress(item: ItemAddress) {
        addresslbl.text = item.name ?? ""
        addressid = item.id ?? 0
    }
    func callbackdelivary(item: GenderModel) {
        delivarymethod.text = item.name ?? ""
        delivaryid = Int(item.type ?? "-1") ?? -1
    }
    func callbacktime(item: GenderModel) {
        timelbl.text = item.name ?? ""
        protimeid = Int(item.type ?? "-1") ?? -1
    }
    func settypeoptin(id: Int, name: String) {
        addresslbl.text = name
        addressid = id
        addressdata.removeAll()
        viewModel?.getaddresss()
    }
}
extension Addproductstep2: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:  self.times.width / 3 - 15 , height: self.times.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pickuptimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.cell(type: PickuptimesCollectionViewCell.self, indexPath)
        cell.model = pickuptimes[safe: indexPath.row]
        cell.timeview.UIViewAction { [self] in
            self.pickid = Int(pickuptimes[indexPath.row].type ?? "") ?? -1
            cell.type = self.pickid
            times.reloadData()
        }
        return cell
    }
    
}
