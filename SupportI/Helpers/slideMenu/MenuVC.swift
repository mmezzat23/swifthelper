//
//  MenuVC.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 4/25/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//#import "SWRevealViewController.h"


import UIKit


enum MenuEnum:String {
    case home
    case favorites
    case my_orders
    case branches
    case settings
    case contact_us
    case about_app
    case usage_policy
    case share_app
}
class MenuModel{
    var name:String!
    var index:MenuEnum?
    var key:String!
    var imageOn:UIImage?
    var imageOff:UIImage?
    
    init(_ name:String , _ key:String!  , _ imageOn:UIImage? = nil , _ imageOff:UIImage? = nil ,_ index:MenuEnum? = nil) {
        self.name = name
        self.key = key
        self.index = index
        self.imageOn = imageOn
        self.imageOff = imageOff
    }
}
class MenuVC: BaseController {
    
    

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var menuCollection: UITableView!
    
    
    static var currentPage:String = "HomeNav"
    static var currentIndex:MenuEnum? = .home
    var menu:[MenuModel] = []
    static func resetMenu(){
        MenuVC.currentPage = "HomeNav"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
        menuCollection.delegate = self
        menuCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func setupMenu(){
        
        menu.append(MenuModel(translate("home"),"HomeNav",#imageLiteral(resourceName: "icHomeMenu2"),#imageLiteral(resourceName: "icHomeMenu"),.home))
        menu.append(MenuModel(translate("favorites"),"FavoritesNav",#imageLiteral(resourceName: "icFavoriteMenu2"),#imageLiteral(resourceName: "icFavoriteMenu"),.favorites))
        menu.append(MenuModel(translate("my_orders"),"OrdersNav",#imageLiteral(resourceName: "icReceipt2"),#imageLiteral(resourceName: "icReceipt"),.my_orders))
        menu.append(MenuModel(translate("company branches"),"BranchesNav",#imageLiteral(resourceName: "icStoreMenu2"),#imageLiteral(resourceName: "icStoreMenu"),.branches))
        menu.append(MenuModel(translate("settings"),"SettingsNav",#imageLiteral(resourceName: "icSettingsMenu2"),#imageLiteral(resourceName: "icSettingsMenu"),.settings))
        menu.append(MenuModel(translate("contact_us"),"ContactUsNav",#imageLiteral(resourceName: "icCallMenu2"),#imageLiteral(resourceName: "icCallMenu"),.contact_us))
        menu.append(MenuModel(translate("about_app"), "AboutUsNav",#imageLiteral(resourceName: "icInfoMenu2"),#imageLiteral(resourceName: "icInfoMenu"),.about_app))
        menu.append(MenuModel(translate("usage_policy"),"AboutUsNav",#imageLiteral(resourceName: "icLockMenu2"),#imageLiteral(resourceName: "icLockMenu"),.usage_policy))
        menu.append(MenuModel(translate("share_app"),"ShareAppNav",#imageLiteral(resourceName: "icShareMenu2"),#imageLiteral(resourceName: "icShareMenu")))
        
        
    }
    func clickOnMenu(menuItem:MenuModel) {
        if menuItem.key != "ShareAppNav"{
            useMenu = true
            MenuVC.currentPage = menuItem.key
            MenuVC.currentIndex = menuItem.index
            let vc = pushViewController(indetifier: menuItem.key)
            push(vc)
        }else{
            shareApp(url: Constants.url)
        }
    }
    
}

extension MenuVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(type: MenuCell(), indexPath,register: false)!
        cell.menu = menu[indexPath.item]
        cell.setup()
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.clickOnMenu(menuItem: menu[indexPath.item])
    }
    
    
}

