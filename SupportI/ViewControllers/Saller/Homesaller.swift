//
//  Homesaller.swift
//  Wndo
//
//  Created by Adam on 10/4/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Homesaller: BaseController {
    @IBOutlet weak var statistecs: UICollectionView!
    @IBOutlet weak var ordermore: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var orders: UITableView!
    @IBOutlet weak var productmore: UILabel!
    @IBOutlet weak var products: UITableView!
    @IBOutlet weak var orderhight: NSLayoutConstraint!
    
    @IBOutlet weak var producthight: NSLayoutConstraint!
    @IBOutlet weak var time: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
    }
    func setup() {
        statistecs.delegate = self
        statistecs.dataSource = self
        orders.delegate = self
        orders.dataSource = self
        products.delegate = self
        products.dataSource = self
        producthight.constant = 3 * 155
        orderhight.constant = 100 + 3 * 80
    }
}
extension Homesaller:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.orders){
            return 3
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.orders){
        var cell = tableView.cell(type: HomeorderTableViewCell.self, indexPath)
        
        return cell
        }else{
            var cell = tableView.cell(type: HomeproductTableViewCell.self, indexPath)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        removeAnimate {
//            self.delegate?.setcatogary(title: self.contries[indexPath.row].title!, image: self.contries[indexPath.row].image! , id : self.contries[indexPath.row].id!)
//        }
    }
    
}
extension Homesaller:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.height)
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
   

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.cell(type: StattistecsCollectionViewCell.self, indexPath)
        return cell
        
    }
    
    
    
}
