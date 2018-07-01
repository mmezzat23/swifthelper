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
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupBase()
        
        if(self.hiddenNav){
            // Show the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false )
            self.navigationController?.navigationBar.shadowImage = UIImage()

        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
     
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



