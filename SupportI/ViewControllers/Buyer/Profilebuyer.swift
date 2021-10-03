//
//  Profilebuyer.swift
//  SupportI
//
//  Created by Adam on 9/21/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import Cosmos
class Profilebuyer: BaseController {
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var followingnum: UILabel!
    @IBOutlet weak var followernum: UILabel!
    @IBOutlet weak var likenum: UILabel!
    @IBOutlet weak var notification: UIView!
    @IBOutlet weak var notnum: UILabel!
    @IBOutlet weak var wishlist: UIView!
    @IBOutlet weak var address: UIView!
    @IBOutlet weak var order: UIView!
    @IBOutlet weak var payment: UIView!
    @IBOutlet weak var setting: UIView!
    @IBOutlet weak var help: UIView!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var image: UIImageView!
    var viewModel : AuthViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        onclick()
        setup()
        bind()
    }
    
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (UserRoot.token() != nil){
        viewModel?.getprofile()
        }else{
            let vcc = self.pushViewController(GuestPopUpViewController.self,storyboard: .main)
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            if (data.responseData?.cover != ""){
                self?.banner.setImage(url: data.responseData?.cover)
            }
            if (data.responseData?.profile != ""){
                self?.image.setImage(url: data.responseData?.cover)
            }
            self?.name.text = data.responseData?.name
            self?.bio.text = data.responseData?.bio
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    @IBAction func edit(_ sender: Any) {
        let vcc = self.controller(Editprofile.self,storyboard: .main)
        self.push(vcc)
    }
    @IBAction func calender(_ sender: Any) {
    }
    
    @IBAction func back(_ sender: Any) {
    }
    
    func onclick(){
        help.UIViewAction {
            let vcc = self.controller(Help.self,storyboard: .setting)
            self.push(vcc)
        }
        payment.UIViewAction {
            let vcc = self.controller(Paymentmethod.self,storyboard: .profile)
            self.push(vcc)
        }
        address.UIViewAction {
            let vcc = self.controller(Address.self,storyboard: .profile)
            self.push(vcc)
        }
        setting.UIViewAction {
            let vcc = self.controller(SettingsProfile.self,storyboard: .profile)
            self.push(vcc)
        }
        notification.UIViewAction {
            let vcc = self.controller(NotificationsViewController.self,storyboard: .setting)
            self.push(vcc)
        }
    }
}

extension Profilebuyer : GuestPopUpDelegate {
    func settype(type: String?) {
        if (type == "contact"){
            let vcc = self.controller(Contactus.self,storyboard: .setting)
            self.push(vcc)
        }else if (type == "signup"){
            let vcc = self.controller(RegisterViewController.self,storyboard: .auth)
            self.push(vcc)
        }
        
    }
    
    
}
