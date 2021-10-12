//
//  BaseController.swift
//  homeCheif
//
//  Created by mohamed abdo on 3/25/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

class BaseController: UIViewController, PresentingViewProtocol, POPUPView, Alertable {

    var hiddenNav: Bool = false
    var pushTranstion: Bool = true
    var popTranstion: Bool = false
    var publicFont: UIFont?

    var centerImageNavigation: UIImageView? {
        didSet {
            if centerImageNavigation != nil {
                let size: CGSize = CGSize(width: centerImageNavigation!.frame.width, height: centerImageNavigation!.frame.height)
                let marginX: CGFloat = (self.navigationController!.navigationBar.frame.size.width / 2) - (size.width / 2)
                centerImageNavigation?.frame =  CGRect(x: marginX, y: 0, width: size.width, height: size.height)
                self.navigationController?.navigationBar.addSubview(centerImageNavigation!)
            }
        }
    }

    @IBOutlet weak var menuBtnButton: UIButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var titleBar: UIBarButtonItem!
    @IBOutlet weak var notificationBtnButton: UIButton!

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    @IBAction func notifyBtn(_ sender: Any) {
        if (UserRoot.saller() == true){
        let vcc = self.controller(NotificationsViewController.self,storyboard: .setting)
        self.push(vcc)
        }
    }
    //var baseViewModel:SettingViewModel?
    //public static var config:Config?
    public static var configLoaded = false
    public static var configRunning = false
    //public static var setting:SettingData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if #available(iOS 13.0, *) {
//            overrideUserInterfaceStyle = .dark
//        } else {
//            // Fallback on earlier versions
//        }
        self.navigationController?.navigationBar.removeSubviews()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.setupBase()
//        if (UserRoot.saller() == true){
//            notificationBtnButton.setImage(#imageLiteral(resourceName: "notify"), for: .normal)
//        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.hiddenNav {
            // Show the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false )
            self.navigationController?.navigationBar.shadowImage = UIImage()

        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        self.navigationController?.navigationBar.removeSubviews()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //baseViewModel = nil
        if self.hiddenNav {
            // Show the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.navigationBar.shadowImage = UIImage()

        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }

    func bind() {

    }
}

extension BaseController: BaseViewControllerProtocol {

    func setupBase() {
        //init menu
        if menuBtn != nil {
            MenuHelper.instance.setUpMenuButton(delegate: self, menuBtn: menuBtn)
        }
        if menuBtnButton != nil {
            MenuHelper.instance.setUpMenuButton(delegate: self, menuBtn: menuBtnButton)
        }
        if !BaseController.configLoaded {
            //baseViewModel = SettingViewModel()
            //baseViewModel?.fetchSetting()
            bindSetting()
        }

        //reset paginator
        ApiManager.instance.resetPaginate()
        //binding
    }
    func bindSetting() {
        //        let closure:(Config)->() = {
        //            BaseController.config = $0
        //            BaseController.configRunning = false
        //            BaseController.configLoaded = true
        //        }
        //        baseViewModel?.setting.bind(closure)
        //
    }

}

extension BaseController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
