//
//  MenuVC.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 4/25/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//#import "SWRevealViewController.h"

import UIKit

enum MenuEnum: String {
    case home
    case payment
    case history
    case notifications
    case settings
    case help
    case logout
}

class MenuModel {
    var name: String!
    var index: MenuEnum?
    var key: String!
    var imageOn: UIImage?
    var imageOff: UIImage?

    init(_ name: String, _ key: String!, _ imageOn: UIImage? = nil, _ imageOff: UIImage? = nil, _ index: MenuEnum? = nil) {
        self.name = name
        self.key = key
        self.index = index
        self.imageOn = imageOn
        self.imageOff = imageOff
    }

}
class MenuVC: BaseController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var menuCollection: UITableView!

    static var currentPage: String = "HomeNav"
    static var currentIndex: MenuEnum? = .home
    var menu: [MenuModel] = []
    static func resetMenu() {
        MenuVC.currentPage = "HomeNav"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
        if menuCollection != nil {
            menuCollection.delegate = self
            menuCollection.dataSource = self
        }
        //userName.text = "\(UserRoot.instance.result?.first_name ?? "") \(UserRoot.instance.result?.last_name ?? "" )"
        //userImage.setImage(url: UserRoot.instance.result?.image)
        // Do any additional setup after loading the view.
    }

    func setupMenu() {

//        menu.append(MenuModel(translate("home"),"HomeNav",#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "home"),.home))
//        menu.append(MenuModel(translate("payment"),"PaymentNav",#imageLiteral(resourceName: "payments"),#imageLiteral(resourceName: "payments"),.payment))
//        menu.append(MenuModel(translate("history"),"HistoryNav",#imageLiteral(resourceName: "history"),#imageLiteral(resourceName: "history"),.history))
//        menu.append(MenuModel(translate("notifications"),"NotificationsNav",#imageLiteral(resourceName: "notification"),#imageLiteral(resourceName: "notification"),.notifications))
//        menu.append(MenuModel(translate("settings"),"SettingsNav",#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "settings"),.settings))
//        menu.append(MenuModel(translate("help"),"HelpNav",#imageLiteral(resourceName: "help"),#imageLiteral(resourceName: "help"),.help))
//        menu.append(MenuModel(translate("logout"),"LogoutNav",#imageLiteral(resourceName: "logout"),#imageLiteral(resourceName: "logout"),.logout))

    }
    func clickOnMenu(menuItem: MenuModel) {
        if menuItem.index == .logout {
//            if UserRoot.isLogin() {
//                UserRoot.removeCacheingDefault()
//                useMenu = true
//                MenuVC.currentIndex = .home
//                let vc = pushViewController(indetifier: Constants.login)
//                push(vc)
//            }
//        }else if menuItem.index == .home {
//            if BaseController.currentTrip?.id != nil {
//                useMenu = true
//                MenuVC.currentPage = menuItem.key
//                MenuVC.currentIndex = menuItem.index
//                let vc = pushViewController(indetifier: "PickupMapNav")
//                push(vc)
//            }else{
//                useMenu = true
//                MenuVC.currentPage = menuItem.key
//                MenuVC.currentIndex = menuItem.index
//                let vc = pushViewController(indetifier: menuItem.key)
//                push(vc)
//            }

        } else {
            MenuVC.currentPage = menuItem.key
            MenuVC.currentIndex = menuItem.index
            let vcr = initViewController(menuItem.key)
            push(vcr)
        }
    }

}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(type: MenuCell.self, indexPath, register: false)
        if MenuVC.currentIndex == menu[indexPath.item].index {
            cell.contentView.backgroundColor = UIColor.colorRGB(red: 239, green: 239, blue: 239)
        }
        cell.menu = menu[indexPath.item]
        cell.setup()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.clickOnMenu(menuItem: menu[indexPath.item])
    }

}
