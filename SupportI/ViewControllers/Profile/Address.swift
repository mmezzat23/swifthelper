//
//  Address.swift
//  SupportI
//
//  Created by Adam on 9/23/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Address: BaseController {
    @IBOutlet weak var address: UITableView!
    var addressdata : [ItemAddress] = []
    var viewModel : ProfileViewModel?
    @IBOutlet weak var saerchtxt: UITextField!
    var path = 0
    @IBOutlet var banner: UIView!
    @IBOutlet weak var notify: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        bind()
    }
    func setup() {
        address.delegate = self
        address.dataSource = self
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.resetPaginator()
        addressdata.removeAll()
        viewModel?.getaddresss()
        if (UserRoot.saller() == true){
            banner.backgroundColor = UIColor(red: 01, green: 14, blue: 47)
            notify.setImage(#imageLiteral(resourceName: "notify"), for: .normal)
        }
    }
    override func bind() {
        viewModel?.addressData.bind({ [weak self](data) in
            self?.stopLoading()
            self?.addressdata.append(contentsOf: data.responseData?.items ?? [])
            self?.address.reloadData()
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    
    @IBAction func addaddress(_ sender: Any) {
        let vcc = self.pushViewController(Addaddress.self,storyboard: .profile)
        self.push(vcc)
    }
    

    @IBAction func search(_ sender: Any) {
    }
    
}
extension Address:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        address.swipeButtomRefresh {
            if case self.viewModel?.runPaginator() = true {
                self.viewModel?.getaddresss()
            } else {
                self.address.stopSwipeButtom()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: AddressTableViewCell.self, indexPath)
        cell.model = addressdata[indexPath.row]
        cell.more.UIViewAction { [self] in
            path = indexPath.row
            let vcc = self.pushViewController(Editdeleteoption.self,storyboard: .profile)
            vcc.delegate = self
            vcc.type = "1"
            self.pushPop(vcr: vcc)
        }
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
    
}
extension Address : EditdeleteoptionDelegate , DeletesuccessDelegate , DeletecardDelegate  {
    func settype() {
        viewModel?.resetPaginator()
        addressdata.removeAll()
        viewModel?.getaddresss()
    }
    
    func settypeoptin() {
        let vcc = self.pushViewController(Deletesuccess.self,storyboard: .profile)
        vcc.type = "1"
        vcc.delegate = self
        self.pushPop(vcr: vcc)
    }
    
    
    func settype(type: String?, action: String?) {
        if (action == "delete") {
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                let vcc = self.pushViewController(Deletecard.self,storyboard: .profile)
                vcc.id = addressdata[path].id ?? 0
                vcc.txt =  addressdata[path].name ?? ""
                vcc.delgate = self
                vcc.type = "1"
                pushPop(vcr: vcc)
            }
           
        }else{
            let vcc = self.pushViewController(Addaddress.self,storyboard: .profile)
            vcc.id = addressdata[path].id ?? 0
            vcc.type = Int(addressdata[path].icon ?? "") ?? 0
            vcc.isedit = true
            self.push(vcc)
        }
    }
    
    
}
