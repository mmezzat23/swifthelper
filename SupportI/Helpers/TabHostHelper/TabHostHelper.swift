//
//  TabHostHelper.swift
//  homeCheif
//
//  Created by Algazzar on 3/29/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import NVActivityIndicatorView

class TabHostHelper: ButtonBarPagerTabStripViewController {
    var useMenu:Bool = true
    var hideNav:Bool = true
    
    
    @IBOutlet weak var navigationBar: UIView!
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var navigationTitle: UILabel!
    
    
    let height:Int! = 52
    let mainBackGroundColor = UIColor.white
    let selectedBackGroundColor = UIColor(red: 122/255, green: 72/255, blue: 145/255, alpha: 1)
    let barHieght = 3
    let oldCellColor = UIColor(red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0)
    let newCellCOlor = UIColor(red: 122/255, green: 72/255, blue: 145/255, alpha: 1)
    let font = UIFont.systemFont(ofSize: 14)
    var navigationBarHeight:Int! = 77

    override func viewDidLoad() {
        if hideNav {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        self.setupTabHost()
        super.viewDidLoad()
        
        self.containerView.isScrollEnabled = false
        self.buttonBarView.frame.origin.y+=CGFloat(self.navigationBarHeight-20)
        // Do any additional setup after loading the view.
        self.setupNavigation()
        self.controlDicrection()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if hideNav {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if hideNav {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
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

}

extension TabHostHelper:PresentingViewProtocol{
    func pushViewController(indetifier:String ,storyboard: String = "Main")->UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: indetifier) as UIViewController
        return vc
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
        settings.style.buttonBarItemFont = self.font
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
