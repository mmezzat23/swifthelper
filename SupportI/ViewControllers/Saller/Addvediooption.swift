//
//  Addvediooption.swift
//  Wndo
//
//  Created by Adam on 10/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

protocol AddvediooptionDelegate: class {
    func settype(type: String? , isvalid: Bool , hasproduct: Bool)
}


class Addvediooption: BaseController {
    @IBOutlet weak var live: UIView!
    @IBOutlet weak var vedio: UIView!
    @IBOutlet weak var product: UIView!
    var delegate : AddvediooptionDelegate?
    var viewModel : SallerViewModel?
    var user : UserRoot?
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        onclick()
        self.view.UIViewAction {
            self.dismiss(animated: true) { [self] in
            }
        }
    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
        viewModel?.isactivesaller()
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.user = data
           
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    func onclick() {
        live.UIViewAction { [self] in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.settype(type: "live", isvalid: user?.responseData?.isActiveSeller ?? false , hasproduct: user?.responseData?.hasProduct ?? false)
        }
        vedio.UIViewAction { [self] in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.settype(type: "vedio", isvalid: user?.responseData?.isActiveSeller ?? false , hasproduct: user?.responseData?.hasProduct ?? false)
           
        }
        product.UIViewAction { [self] in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.settype(type: "product", isvalid: user?.responseData?.isActiveSeller ?? false, hasproduct: user?.responseData?.hasProduct ?? false)
           
        }
    }
}
