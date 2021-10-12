//
//  Faq.swift
//  SupportI
//
//  Created by Adam on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Faq: BaseController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var sendmessage: UIView!
    var faqsdata : [ItemFaq] = []
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    @IBOutlet var banner: UIView!
    
    @IBOutlet weak var notify: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        if (UserRoot.saller() == true){
            banner.backgroundColor = UIColor(red: 01, green: 14, blue: 47)
            notify.setImage(#imageLiteral(resourceName: "notify"), for: .normal)
        }
        sendmessage.UIViewAction {
            let vcc = self.controller(Contactus.self,storyboard: .setting)
            self.push(vcc)
        }
    }
    
    func setup() {
        tableview.delegate = self
        tableview.dataSource = self
        viewModel = .init()
        viewModel?.delegate = self
        parameters["isSeller"] = UserRoot.saller()
        viewModel?.getfaqs(paramters: parameters)
    }
    override func bind() {
        viewModel?.faqsData.bind({ [weak self](data) in
            self?.stopLoading()
            self?.faqsdata.append(contentsOf: data.responseData?.items ?? [])
            self?.tableview.reloadData()
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
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
extension Faq:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        tableview.swipeButtomRefresh {
            if case self.viewModel?.runPaginator() = true {
                self.viewModel?.getfaqs(paramters: self.parameters)
            } else {
                self.tableview.stopSwipeButtom()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqsdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: FaqTableViewCell.self, indexPath)
        cell.model = faqsdata[indexPath.row]
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
    
}
