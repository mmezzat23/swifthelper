//
//  ViewController.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import UIKit

class ViewController: BaseController {

    @IBOutlet weak var collection: UITableView!
    var viewModel:TestViewModel = TestViewModel()
    var city:SelectDropDownModel = SelectDropDownModel()
    var list:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        bind()
    }
    override func viewDidAppear(_ animated: Bool) {
//        let map = GoogleMapHelper()
//        map.showPlacePicker()
//    
        
    }
    
    func setup() {
        collection.delegate = self
        collection.dataSource = self
        collection.swipeTopRefresh(closure: swipeTop)
        collection.swipeButtomRefresh(closure: swipeButtom)
        
        
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
    }
    func swipeTop(){
        print("testtt")
        self.list.removeAll()
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        list.append("test")
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.collection.reloadData {
                self.collection.stopSwipeTop()
            }
        }
    }
    func swipeButtom(){
        print("testtt")
        self.list.append("")
        self.list.append("")
        self.list.append("")
        self.list.append("")
        self.list.append("")
        self.list.append("")
        self.list.append("")
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.collection.reloadData {
                self.collection.stopSwipeButtom()
            }
        }
        
    }
    override func bind() {
        // Set View Model Event Listener
        viewModel.model.bind{value in
            self.city = value
        }
    }

    
}


extension ViewController:UITableViewDelegate , UITableViewDataSource , SwipeRefreshDelegate {
    func swipeTopEvent() {
        print("topppp")
    }
    func swipeButtomEvent() {
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.swipeButtomRefresh {
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.cell(type: TestCell.self, indexPath,register: false) else { return UITableViewCell() }
        cell.setup()
        return cell
    }
    

    
}


class TestCell:UITableViewCell , CellProtocol {
    
    func setup() {
        
    }
}
//import GooglePlacePicker
//extension ViewController:PlacesPickerDelegate {
//    func didPickPlace(place: GMSPlace) {
//        print(place)
//    }
//}

