//
//  BaseController.swift
//  homeCheif
//
//  Created by mohamed abdo on 3/25/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

import NVActivityIndicatorView

class BaseController : UIViewController,PresentingViewProtocol,POPUPView{
    
    var hiddenNav:Bool = false
    var useMenu:Bool = false
    var pushTranstion:Bool = true
    var popTranstion:Bool = false
    
    var publicFont:UIFont? = nil
    var centerTitleNavigation:String? {
        didSet{
            if centerTitleNavigation != nil {
                let size:CGSize = CGSize(width: 100, height: 40)
                let marginX:CGFloat = (self.navigationController!.navigationBar.frame.size.width / 2) - (size.width / 2)
                let label1 = UILabel(frame: CGRect(x: marginX, y: 0, width: size.width, height: size.height))
                label1.text = centerTitleNavigation
                label1.textAlignment = .center
                label1.textColor = Constants.textColorRGB
                if publicFont != nil {
                    label1.font = publicFont!
                }
                self.navigationController?.navigationBar.addSubview(label1)
            }
        }
    }
    var centerImageNavigation:UIImageView? {
        didSet{
            if centerImageNavigation != nil {
                let size:CGSize = CGSize(width: centerImageNavigation!.frame.width, height: centerImageNavigation!.frame.height)
                let marginX:CGFloat = (self.navigationController!.navigationBar.frame.size.width / 2) - (size.width / 2)
                centerImageNavigation?.frame =  CGRect(x: marginX, y: 0, width:size.width, height: size.height)
                self.navigationController?.navigationBar.addSubview(centerImageNavigation!)
            }
        }
    }
    @IBOutlet weak var menuBtnButton: UIButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var titleBar: UIBarButtonItem!
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    
    //var baseViewModel:SettingViewModel?
    //public static var config:Config?
    public static var configLoaded = false
    public static var configRunning = false
    //public static var setting:SettingData?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.removeSubviews()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.setupBase()
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if(self.hiddenNav){
            // Show the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false )
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        self.navigationController?.navigationBar.removeSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //baseViewModel = nil
        if(self.hiddenNav){
            // Show the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    
    func bind() {
        
    }
}



extension BaseController:BaseViewControllerProtocol{
    
    
    func setupBase() {
        //init menu
        if(menuBtn != nil){
            MenueHelper.instance.setUpMenuButton(delegate: self, menuBtn: menuBtn)
        }
        if(menuBtnButton != nil){
            MenueHelper.instance.setUpMenuButton(delegate: self, menuBtn: menuBtnButton)
        }
        if(!BaseController.configLoaded){
            //baseViewModel = SettingViewModel()
            //baseViewModel?.fetchSetting()
            bindSetting()
        }
        
        //reset paginator
        ApiManager.instance.resetPaginate()
        ApiManager.instance.resetObject()
        //binding
    }
    func bindSetting(){
        //        let closure:(Config)->() = {
        //            BaseController.config = $0
        //            BaseController.configRunning = false
        //            BaseController.configLoaded = true
        //        }
        //        baseViewModel?.setting.bind(closure)
        //
    }
    func pushViewController(indetifier:String ,storyboard: String = Constants.storyboard)->UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: indetifier)
        return vc
    }
    func pushViewController<T>(_ indetifier:T.Type ,storyboard: String = Constants.storyboard)->T{
        
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: String(describing: indetifier))
        return vc as! T
    }
    
    func push(_ view:UIViewController,_ animated:Bool = true)  {
        if useMenu{
            let topController = UIApplication.shared.keyWindow?.rootViewController as! SWRevealViewController
            topController.pushFrontViewController(view, animated: animated)
        }else{
            self.navigationController?.delegate = self
            view.transitioningDelegate = self
            self.navigationController?.pushViewController(view, animated: animated)
        }
    }
    
    
}

extension BaseController:UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}



