//
//  ViewController.swift
//
//  Created by mohamed abdo on 11/4/18.
//  Copyright © 2018 Onnety. All rights reserved.
//

import UIKit

protocol PickersPOPDelegate:class {
    func callbackgenders(item: GenderModel)
    func callbackCity(item:ItemCity)
//    func callbackCategory(item:Category )
//    func callbacksubcat(item:Category)
    func callbackCustom(item:PickerModel ,returnedKey: String)
    func callbackDate(item:String , returnedKey:String)
//    func callbackOrders(item:OrderModel)

    //func callbackDate(countryItem:CountryData , returnedKey:String)
}
extension PickersPOPDelegate {
    func callbackgenders(item:GenderModel ){

    }
//    func callbackOrders(item:OrderModel ){
//
//    }
    func callbackCity(item:ItemCity){

    }
//    func callbackCategory(item:Category ){
//
//    }
//    func callbacksubcat(item:Category){
//
//    }
    func callbackCustom(item:PickerModel ,returnedKey: String){
        
    }
    func callbackDate(item:String , returnedKey:String){
        
        
    }
}

class PickerModel {
    var title:String?
    var titleorginal:String?
    var id:String?
}
class PickersPOP:BaseController {

    enum PickerSelection {
        case country
        case city
        case gender
        case category
        case custom
        case subcat
        case order
    }
    enum DateSelection {
        case date
        case time
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    weak var delegate:PickersPOPDelegate?
    var openWhat:String = ""
    var pickerSelection:PickerSelection = .country
    var dateSelection:DateSelection = .date
    var returnedKey:String = ""
    var genders:[GenderModel] = []
    var cities:[ItemCity] = []
//    var categories:[Category] = []
//    var orders:[OrderModel] = []
//    var subcategories:[Category] = []
    var customs:[PickerModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        bind()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
   
    func setup() {
        if openWhat == "picker"{
            pickerView.isHidden = false
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.reloadAllComponents()
        }else{
            datePicker.isHidden = false
            //Formate Date
            if dateSelection == .date {
                datePicker.datePickerMode = .date
            }else{
                datePicker.datePickerMode = .time
            }
            //ToolBar
//            let toolbar = UIToolbar()
//            toolbar.sizeToFit()
//            //done button & cancel button
//            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: "donedatePicker")
//            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//            let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: "cancelDatePicker")
//            toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//            // add toolbar to textField
//            txtDatePicker.inputAccessoryView = toolbar
            // add datepicker to textField
            //txtDatePicker.inputView = datePicker

        }
       
    }
    override func bind() {
        
    }
    
    @IBAction func agree(_ sender: Any) {
        if openWhat == "picker"{
//            if pickerSelection == .country {
//                let path = pickerView.selectedRow(inComponent: 0)
//                if countries.isset(path){
//                    let item = countries[pickerView.selectedRow(inComponent: 0)]
//                    self.dismiss(animated: true) {
//                        self.delegate?.callbackCountry(item: item)
//                    }
//                }
//
//            }else
            if pickerSelection == .city {
                let path = pickerView.selectedRow(inComponent: 0)
                if cities.isset(path){
                    let item = cities[pickerView.selectedRow(inComponent: 0)]
                    self.dismiss(animated: true) {
                        self.delegate?.callbackCity(item: item)
                    }
                }
                
            }
            else if pickerSelection == .gender {
                let path = pickerView.selectedRow(inComponent: 0)
                if genders.isset(path){
                    let item = genders[pickerView.selectedRow(inComponent: 0)]
                    self.dismiss(animated: true) {
                        self.delegate?.callbackgenders(item: item)
                    }
                }
//
//            }else if pickerSelection == .category {
//                let path = pickerView.selectedRow(inComponent: 0)
//                if categories.isset(path){
//                    let item = categories[pickerView.selectedRow(inComponent: 0)]
//                    self.dismiss(animated: true) {
//                        self.delegate?.callbackCategory(item: item)
//                    }
//                }
//
//
//        }else if pickerSelection == .order {
//                let path = pickerView.selectedRow(inComponent: 0)
//                if orders.isset(path){
//                    let item = orders[pickerView.selectedRow(inComponent: 0)]
//                    self.dismiss(animated: true) {
//                        self.delegate?.callbackOrders(item: item)
//                    }
//                }
//
//            }else if pickerSelection == .custom {
//                let path = pickerView.selectedRow(inComponent: 0)
//                if customs.isset(path){
//                    let item = customs[pickerView.selectedRow(inComponent: 0)]
//                    self.dismiss(animated: true) {
//                        self.delegate?.callbackCustom(item: item, returnedKey: self.returnedKey)
//                    }
//                }
                
            
        }
    }else{
            
            if dateSelection == .date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyy/MM/dd"
                let date = formatter.string(from: datePicker.date)
                self.view.endEditing(true)
                self.dismiss(animated: true) {
                    self.delegate?.callbackDate(item: date, returnedKey: self.returnedKey)
                }
            }else{
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let time = formatter.string(from: datePicker.date)
                print(time)
                self.view.endEditing(true)
                self.dismiss(animated: true) {
                    self.delegate?.callbackDate(item: time, returnedKey: self.returnedKey)
                }
            }
           
            
          
        }
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PickersPOP:UIPickerViewDelegate , UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerSelection == .country {
//            return countries.count
//        }else
        if pickerSelection == .city{
            return cities.count
        }
        else if pickerSelection == .gender {
            return genders.count
        }
//        else if pickerSelection == .subcat {
//            return subcategories.count
//        } else if pickerSelection == .custom {
//            return customs.count
//        }
        return 0
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerSelection == .country {
//            return countries[row].name
//        }else
        if pickerSelection == .city{
            return cities[row].name
        }
        else if pickerSelection == .gender {
            return genders[row].name
        }
//        else if pickerSelection == .subcat {
//            return subcategories[row].name
//        } else if pickerSelection == .custom {
//            return customs[row].title
//        }
        
        return nil
    }
}
