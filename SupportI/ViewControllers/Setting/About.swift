//
//  About.swift
//  SupportI
//
//  Created by Adam on 9/21/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class About: BaseController {
    @IBOutlet weak var txt: UILabel!
    @IBOutlet weak var more: UILabel!
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    var social : UserRoot?
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        more.setunderline(title: "For More Details, please visit us")
        setup()
        bind()
    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
       parameters["isSeller"] = UserRoot.saller()
       parameters["dto"] = 1
       viewModel?.getinfo(paramters: parameters)
       viewModel?.getsocial()
   }
    
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.txt.text = data.responseData?.text?.htmlToString
           
        })
        viewModel?.socialdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.social = data
           
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    @IBAction func website(_ sender: Any) {
        openUrl(text: social?.responseData?.website ?? "")
    }
    
    @IBAction func twitt(_ sender: Any) {
        openUrl(text: social?.responseData?.twitter ?? "")
    }
    
    @IBAction func face(_ sender: Any) {
        openUrl(text: social?.responseData?.facebook ?? "")
    }
}
