//
//  ViewController.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import UIKit

class ViewController: BaseController {

    var viewModel:TestViewModel = TestViewModel()
    var city:SelectDropDownModel = SelectDropDownModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
        bind()
    }
    
    
    override func bind() {
        // Set View Model Event Listener
        viewModel.model.bind{value in
            self.city = value
        }
    }

}

