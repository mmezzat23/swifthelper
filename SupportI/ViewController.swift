//
//  ViewController.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import UIKit

class ViewController: BaseController {
    @IBOutlet weak var imageView: UIImageView!
    var viewModel: TestViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setup()
    }

    func setup() {
        print(Localizations.sure.localized)
        print("sound.lan".localized())

        //        let vc = controller(CustomViewController.self, storyboard: .main)
        //        push(vc)
        viewModel = .init()
        viewModel?.fetchData()
        displayImage(image: imageView.image)
    }
    override func bind() {
        viewModel?.model.bind({ (_) in

        })
    }

}

// Source UIViewController
extension ViewController: ImageDisplayInterface {

}
