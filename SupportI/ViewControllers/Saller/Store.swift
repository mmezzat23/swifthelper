//
//  Store.swift
//  Wndo
//
//  Created by Adam on 14/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Store: BaseController {
    @IBOutlet weak var offers: UIView!
    @IBOutlet weak var offerlbl: UILabel!
    @IBOutlet weak var offerline: UIView!
    @IBOutlet weak var product: UIView!
    @IBOutlet weak var productlbl: UILabel!
    @IBOutlet weak var productline: UIView!
    @IBOutlet weak var vedios: UIView!
    @IBOutlet weak var vedioslbl: UILabel!
    @IBOutlet weak var vediosline: UIView!
    @IBOutlet weak var searchtxt: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var noresult: UIView!
    @IBOutlet weak var live: UIView!
    var products : [ProductsResponseDatum] = []
    var vediositems : [VediosModelitem] = []
    var path = 0

    var type = 0
    var viewModel : SallerViewModel?
    var parameters : [String : Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func setup() {
        tableview.delegate = self
        tableview.dataSource = self
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.resetPaginator()
        products.removeAll()
        viewModel?.getsalleroffers()
        viewModel?.getcount()
        offers.UIViewAction { [self] in
            if (type != 0 ){
                type = 0
                viewModel?.resetPaginator()
                products.removeAll()
                viewModel?.getsalleroffers()
                offerline.isHidden = false
                productline.isHidden = true
                vediosline.isHidden = true
                offerlbl.textColor = UIColor(red: 1, green: 20, blue: 71)
                vedioslbl.textColor = UIColor(red: 150, green: 161, blue: 171)
                productlbl.textColor = UIColor(red: 150, green: 161, blue: 171)

            }
        }
        
        product.UIViewAction { [self] in
            if (type != 1 ){
                type = 1
                viewModel?.resetPaginator()
                products.removeAll()
                viewModel?.getsallerproducts()
                offerline.isHidden = true
                productline.isHidden = false
                vediosline.isHidden = true
                productlbl.textColor = UIColor(red: 1, green: 20, blue: 71)
                offerlbl.textColor = UIColor(red: 150, green: 161, blue: 171)
                vedioslbl.textColor = UIColor(red: 150, green: 161, blue: 171)

            }
        }
        vedios.UIViewAction { [self] in
            if (type != 2 ){
                type = 2
                viewModel?.resetPaginator()
                vediositems.removeAll()
                viewModel?.getsallervedios()
                vediosline.isHidden = false
                productline.isHidden = true
                offerline.isHidden = true
                vedioslbl.textColor = UIColor(red: 1, green: 20, blue: 71)
                offerlbl.textColor = UIColor(red: 150, green: 161, blue: 171)
                productlbl.textColor = UIColor(red: 150, green: 161, blue: 171)

            }
        }
    }
    override func bind() {
       
        viewModel?.productssdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.products.append(contentsOf: data.responseData ?? [])
            if (self?.products.count == 0){
                self?.noresult.isHidden = false
            }else{
                self?.noresult.isHidden = true

            }
            self?.tableview.reloadData()
            
        })
        viewModel?.vediosdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.vediositems.append(contentsOf: data.responseData?.items ?? [])
            if (self?.vediositems.count == 0){
                self?.noresult.isHidden = false
            }else{
                self?.noresult.isHidden = true

            }
            self?.tableview.reloadData()
            
        })
        viewModel?.productdetailsdata.bind({ [weak self](data) in
            self?.stopLoading()
            if (data.responseData?.status != 3){
                let vcc = self?.controller(Addproduct.self,storyboard: .addproduct)
                vcc?.productdetails = data
                vcc?.isedit = true
                self?.push(vcc!)
            }else {
                let vcc = self?.controller(Rejectedproduct.self,storyboard: .addproduct)
                vcc?.productdetails = data
                vcc?.isedit = true
                self?.push(vcc!)
            }
            
            
        })
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.productlbl.text = "\("Products".localized()) (\(data.responseData?.products ?? 0))"
            self?.offerlbl.text = "\("Offers".localized()) (\(data.responseData?.offers ?? 0))"
            self?.vedioslbl.text = "\("Videos".localized()) (\(data.responseData?.videos ?? 0))"

        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
           
    }
    @IBAction func filter(_ sender: Any) {
    }
    

}
extension Store:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        tableview.swipeButtomRefresh { [self] in
            if case self.viewModel?.runPaginator() = true {
                if (type == 0){
                    self.viewModel?.getsalleroffers()
                }else if (type == 1){
                    self.viewModel?.getsallerproducts()
                }else if (type == 2){
                    self.viewModel?.getsallervedios()
                }
            } else {
                self.tableview.stopSwipeButtom()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (type == 2){
        return vediositems.count ?? 0
        }else{
        return products.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (type == 2){
            var cell = tableView.cell(type: VediosTableViewCell.self, indexPath)
            cell.model = vediositems[indexPath.row]
            cell.setup()
            cell.delegate = self
            cell.play.UIViewAction { [self] in
                let vcc = self.controller(Playvedio.self,storyboard: .vedios)
                vcc.playid = vediositems[indexPath.row].urlPreview ?? ""
                self.push(vcc)
            }
            return cell
        }else {
        var cell = tableView.cell(type: ProductsTableViewCell.self, indexPath)
        cell.model = products[indexPath.row]
        cell.setup()
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
extension Store : ProductsTableViewCellDelegate , VediosTableViewCellDelegate{
    func more(wasPressedOnCell cell: VediosTableViewCell, path: Int) {
        if (type == 2){
            self.path = path
            let vcc = self.pushViewController(Editdeleteoption.self,storyboard: .profile)
            vcc.type =  "vedio"
            vcc.delegate = self
            self.pushPop(vcr: vcc)
        }else{
            self.path = path
            let vcc = self.pushViewController(Editdeleteoption.self,storyboard: .profile)
            vcc.type =  "product"
            vcc.delegate = self
            self.pushPop(vcr: vcc)
        }
    }
    
    func more(wasPressedOnCell cell: ProductsTableViewCell, path: Int) {
            if (type == 2){
                self.path = path
                let vcc = self.pushViewController(Editdeleteoption.self,storyboard: .profile)
                vcc.type =  "vedio"
                vcc.delegate = self
                self.pushPop(vcr: vcc)
            }else{
                self.path = path
                let vcc = self.pushViewController(Editdeleteoption.self,storyboard: .profile)
                vcc.type =  "product"
                vcc.delegate = self
                self.pushPop(vcr: vcc)
            }
        
    }
    
    
}
extension Store : EditdeleteoptionDelegate , DeletesuccessDelegate , DeletecardDelegate{
    func settype() {
        if (type == 0){
          viewModel?.resetPaginator()
          products.removeAll()
          viewModel?.getsalleroffers()
        }else if (type == 1){
            viewModel?.resetPaginator()
            products.removeAll()
            viewModel?.getsallerproducts()
        }else if (type == 2){
            viewModel?.resetPaginator()
            vediositems.removeAll()
            viewModel?.getsallervedios()
          }
        viewModel?.getcount()

    }
     
    func settypeoptin() {
        if (type == 0){
            let vcc = self.pushViewController(Deletesuccess.self,storyboard: .profile)
            vcc.type = "product"
            vcc.delegate = self
            self.pushPop(vcr: vcc)
        }else if (type == 1){
            let vcc = self.pushViewController(Deletesuccess.self,storyboard: .profile)
            vcc.type = "product"
            vcc.delegate = self
            self.pushPop(vcr: vcc)
        }else if (type == 2){
            let vcc = self.pushViewController(Deletesuccess.self,storyboard: .profile)
            vcc.type = "vedio"
            vcc.delegate = self
            self.pushPop(vcr: vcc)
          }
       
    }
    func settype(type: String?, action: String?) {
        if (action == "delete") {
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                if (type == "vedio") {
                    let vcc = self.pushViewController(Deletecard.self,storyboard: .profile)
                    vcc.id = vediositems[path].id ?? 0
                    vcc.productid = vediositems[path].videoID ?? ""
                    vcc.txt =  vediositems[path].name ?? ""
                    vcc.delgate = self
                    vcc.type =  "vedio"
                    pushPop(vcr: vcc)
                }else {
                    let vcc = self.pushViewController(Deletecard.self,storyboard: .profile)
                    vcc.productid = products[path].id ?? ""
                    vcc.txt =  products[path].name ?? ""
                    vcc.delgate = self
                    vcc.type =  "product"
                    pushPop(vcr: vcc)
                }
            }
           
        }else {
            if (type == "vedio") {
            }else {
                parameters["productId"] = products[path].id ?? ""
                viewModel?.getproductdetails(paramters: parameters)
            }
        }
    }
    
}
