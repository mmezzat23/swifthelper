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
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
    }
    
    func setup() {
        address.delegate = self
        address.dataSource = self
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.getaddresss()
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
    
}
extension Address:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: AddressTableViewCell.self, indexPath)
        cell.model = addressdata[indexPath.row]
        cell.setup()
        return cell
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action =  UIContextualAction(style: .destructive, title: "", handler: { [self] (action,view,completionHandler ) in
            let vcc = self.pushViewController(Deletecard.self,storyboard: .profile)
            vcc.id = addressdata[indexPath.row].id ?? 0
            vcc.txt =  addressdata[indexPath.row].name ?? ""
            vcc.type = "1"
            pushPop(vcr: vcc)
            completionHandler(true)
            })
            
            action.image = UIImage(named: "Fill -2")
            
            action.backgroundColor = UIColor(red: 0x01, green: 0x14, blue: 0x47)
        let editaction =  UIContextualAction(style: .destructive, title: "", handler: { [self] (action, view, completionHandler ) in
                self.startLoading()
                let vcc = self.pushViewController(Addaddress.self,storyboard: .profile)
                vcc.id = addressdata[indexPath.row].id ?? 0
                vcc.isedit = true
                self.push(vcc)
                completionHandler(true)
            })
            
            editaction.image = UIImage(named: "edit-1")

            editaction.backgroundColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            let confrigation = UISwipeActionsConfiguration(actions: [action , editaction])
            return confrigation
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
    
}
