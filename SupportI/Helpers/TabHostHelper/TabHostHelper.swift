//
//  TabHostHelper.swift
//  homeCheif
//
//  Created by Algazzar on 3/29/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TabHostHelper: ButtonBarPagerTabStripViewController {
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var menuBtnButton: UIButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    var useMenu:Bool = true
    var hiddenNav:Bool = false
    var pushTransition:Bool = true
    
    
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
    
    
    let height:Int! = 52
    let mainBackGroundColor = UIColor.white
    let selectedBackGroundColor = Constants.mainColorRGB
    let barHieght = 3
    let oldCellColor = UIColor.colorRGB(red: 168, green: 168, blue: 168)
    let newCellCOlor = Constants.mainColorRGB
    lazy var font = self.publicFont
    var navigationBarHeight:Int! = 77

    
  
    override func viewDidLoad() {
        self.hideNavigation()
        self.setupTabHost()
        super.viewDidLoad()
        self.navigationController?.navigationBar.removeSubviews()
        self.navigationItem.setHidesBackButton(true, animated: false)

        self.containerView.isScrollEnabled = false
        if self.navigationBar != nil {
            self.buttonBarView.frame.origin.y+=CGFloat(self.navigationBarHeight-20)
        }else{
            self.buttonBarView.frame.origin.y+=CGFloat(0)
        }
        // Do any additional setup after loading the view.
        self.setupNavigation()
        self.controlDicrection()
        
        //init menu
        if(menuBtn != nil){
            MenueHelper.instance.setUpMenuButton(delegate: self, menuBtn: menuBtn)
        }
        if(menuBtnButton != nil){
            MenueHelper.instance.setUpMenuButton(delegate: self, menuBtn: menuBtnButton)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.hideNavigation()
    }
    func hideNavigation(){
        if hiddenNav {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        self.navigationController?.navigationBar.removeSubviews()
    }
    func setupNavigation(){
        if(self.navigationBar != nil){
            self.view.addSubview(navigationBar)
        }else{
            self.navigationController?.navigationBar.shadowRadius = 0
            self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 0)
            self.navigationController?.navigationBar.shadowOpacity = 0
            self.navigationController?.navigationBar.shadowColor = nil
        }
        shadow(radius: 2, height:1, opacity: 0.5, color: UIColor.colorRGB(red: 0, green: 0, blue: 0,alpha: 0.30))
    }
    func controlDicrection(){
        if(getAppLang() == "ar"){
            self.buttonBarView.moveTo(index: viewControllers.count-1, animated: false, swipeDirection: .left, pagerScroll: .yes)
            moveToViewController(at: viewControllers.count-1)
        }else{
            self.buttonBarView.moveTo(index: 0, animated: false, swipeDirection: .left, pagerScroll: .yes)
            moveToViewController(at: 0)
        }
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension TabHostHelper:PresentingViewProtocol{
    
    func pushViewController(indetifier:String ,storyboard: String = "Main")->UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: indetifier) as UIViewController
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
            self.navigationController?.pushViewController(view, animated: animated)
        }
    }
    
    
    
}
extension TabHostHelper {

    func setupTabHost(){

        // barHeight is only set up when the bar is created programmatically and not using storyboards or xib files as recommended.
        settings.style.buttonBarHeight = CGFloat(self.height)
        self.settings.style.selectedBarBackgroundColor = self.selectedBackGroundColor
        settings.style.buttonBarBackgroundColor =  self.mainBackGroundColor
        if self.font != nil{
            settings.style.buttonBarItemFont = self.font!
        }
        
        // buttonBar minimumInteritemSpacing value, note that button bar extends from UICollectionView
        //        settings.style.buttonBarMinimumInteritemSpacing = CGFloat(5)
        //        // buttonBar minimumLineSpacing value
        //        settings.style.buttonBarMinimumLineSpacing =  CGFloat(5)
        //        // buttonBar flow layout left content inset value
        //        settings.style.buttonBarLeftContentInset = CGFloat(5)
        //        // buttonBar flow layout right content inset value
        //        settings.style.buttonBarRightContentInset = CGFloat(5)
        
        // selected bar view is created programmatically so it's important to set up the following 2 properties properly
        settings.style.selectedBarHeight = CGFloat(self.barHieght)
        
        // each buttonBar item is a UICollectionView cell of type ButtonBarViewCell
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        // helps to determine the cell width, it represent the space before and after the title label
        settings.style.buttonBarItemTitleColor = UIColor(red: 129/255, green: 186/255, blue: 0/255, alpha: 1)
        // in case the barView items do not fill the screen width this property stretch the cells to fill the screen
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        // only used if button bar is created programmatically and not using storyboards or nib files as recommended.
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self.oldCellColor
            newCell?.label.textColor = self.newCellCOlor
        }
    }
    
    func shadow(radius:CGFloat ,height:CGFloat,opacity:Float, color:UIColor){
        //        self.buttonBarView.layer.shadowRadius = radius
        //        self.buttonBarView.layer.shadowColor = color.cgColor
        //        self.buttonBarView.layer.shadowOffset = CGSize(width: 0, height: height)
        //        self.buttonBarView.layer.shadowOpacity = opacity
        //        self.buttonBarView.layer.masksToBounds = false
        
        self.buttonBarView.layer.shadowColor = color.cgColor
        self.buttonBarView.layer.shadowOffset = CGSize(width: 0, height: height)
        self.buttonBarView.layer.shadowOpacity = 0.5
        self.buttonBarView.layer.shadowRadius = 1
        self.buttonBarView.layer.masksToBounds = false
        //self.buttonBarView.layer.cornerRadius = 4.0
        
    }
    
}
