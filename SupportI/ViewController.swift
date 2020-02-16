//
//  ViewController.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import UIKit

class ViewController: BaseController {
    
    var viewModel: TestViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setup()
    }
    
    func setup() {
        print("sound.lan".localized)
        print("sound.lan".localized())
        
        //        let vc = controller(CustomViewController.self, storyboard: .main)
        //        push(vc)
        viewModel = .init()
        viewModel?.fetchData()
        
    }
    override func bind() {
        viewModel?.model.bind({ (data) in
            
        })
    }
 
}

