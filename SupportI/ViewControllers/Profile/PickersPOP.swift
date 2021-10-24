//
//  ViewController.swift
//
//  Created by mohamed abdo on 11/4/18.
//  Copyright © 2018 Onnety. All rights reserved.
//

import UIKit

protocol PickersPOPDelegate:class {
    func callbackgenders(item: GenderModel)
    func callbackdelivary(item: GenderModel)
    func callbacktime(item: GenderModel)
    func callbackaddress(item:ItemAddress)
    func callbackreasons(item: ResponseDatum)
    func callbackSize(item: SectionItem, path: Int)
    func callbackColor(item: SectionItem, path: Int)
    func callbackLookup(item:LookupValue , path:Int)
    func callbackCity(item:ItemCity)
    func callbacksection(item:SectionItem )
    func callbackCategory(item:SectionItem )
    func callbacksubcat(item:SectionItem)
    func callbackCustom(item:PickerModel ,returnedKey: String)
    func callbackDate(item:String , returnedKey:String)
//    func callbackOrders(item:OrderModel)

    //func callbackDate(countryItem:CountryData , returnedKey:String)
}
extension PickersPOPDelegate {
    func callbackdelivary(item:GenderModel ){

    }
    func callbacktime(item:GenderModel ){

    }
    func callbackaddress(item:ItemAddress){

    }
    func callbackgenders(item:GenderModel ){

    }
    func callbackreasons(item:ResponseDatum ){

    }
//    func callbackOrders(item:OrderModel ){
//
//    }
    func callbackSize(item: SectionItem, path: Int){

    }
    func callbackColor(item: SectionItem, path: Int){

    }
    func callbackLookup(item:LookupValue , path:Int){

    }
    func callbackCity(item:ItemCity){

    }
    func callbacksection(item:SectionItem ){

    }
    func callbackCategory(item:SectionItem ){

    }
    func callbacksubcat(item:SectionItem){

    }
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
        case section
        case custom
        case subcat
        case order
        case raeson
        case lookup
        case size
        case color
        case delivary
        case time
        case address
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
    var raesons:[ResponseDatum] = []
    var lookups: [LookupValue] = []
    var sizes: [SectionItem] = []
    var colors: [SectionItem] = []
    var date = ""
    var sections : [SectionItem] = []
    var cats : [SectionItem] = []
    var subcats : [SectionItem] = []
    var cities:[ItemCity] = []
    var isproduct = false
//    var categories:[Category] = []
//    var orders:[OrderModel] = []
//    var subcategories:[Category] = []
    var customs:[PickerModel] = []
    var path = 0
    var delevariymethods : [GenderModel] = []
    var protimes : [GenderModel] = []
    var addressdata : [ItemAddress] = []

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
            if (isproduct == false){
                datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
            }else {
                datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
            }
            if (date != ""){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                datePicker.date = dateFormatter.date (from: date)!
            }
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
                }  else if pickerSelection == .time {
                    let path = pickerView.selectedRow(inComponent: 0)
                    if protimes.isset(path){
                        let item = protimes[pickerView.selectedRow(inComponent: 0)]
                        self.dismiss(animated: true) {
                            self.delegate?.callbacktime(item: item)
                        }
                    }
                    } else if pickerSelection == .delivary {
                        let path = pickerView.selectedRow(inComponent: 0)
                        if delevariymethods.isset(path){
                            let item = delevariymethods[pickerView.selectedRow(inComponent: 0)]
                            self.dismiss(animated: true) {
                                self.delegate?.callbackdelivary(item: item)
                            }
                        }
                        } else if pickerSelection == .address {
                            let path = pickerView.selectedRow(inComponent: 0)
                            if addressdata.isset(path){
                                let item = addressdata[pickerView.selectedRow(inComponent: 0)]
                                self.dismiss(animated: true) {
                                    self.delegate?.callbackaddress(item: item)
                                }
                            }
                            } else if pickerSelection == .lookup {
                    let path = pickerView.selectedRow(inComponent: 0)
                    if lookups.isset(path){
                        let item = lookups[pickerView.selectedRow(inComponent: 0)]
                        self.dismiss(animated: true) {
                            self.delegate?.callbackLookup(item: item, path: self.path)
                        }
                    }
                    }   else if pickerSelection == .size {
                        let path = pickerView.selectedRow(inComponent: 0)
                        if sizes.isset(path){
                            let item = sizes[pickerView.selectedRow(inComponent: 0)]
                            self.dismiss(animated: true) {
                                self.delegate?.callbackSize(item: item, path: self.path)
                            }
                        }
                        }  else if pickerSelection == .color {
                            let path = pickerView.selectedRow(inComponent: 0)
                            if colors.isset(path){
                                let item = colors[pickerView.selectedRow(inComponent: 0)]
                                self.dismiss(animated: true) {
                                    self.delegate?.callbackColor(item: item, path: self.path)
                                }
                            }
                            }else if pickerSelection == .raeson {
                    let path = pickerView.selectedRow(inComponent: 0)
                    if raesons.isset(path){
                        let item = raesons[pickerView.selectedRow(inComponent: 0)]
                        self.dismiss(animated: true) {
                            self.delegate?.callbackreasons(item: item)
                        }
                    }
                
//
            }else if pickerSelection == .category {
                let path = pickerView.selectedRow(inComponent: 0)
                if cats.isset(path){
                    let item = cats[pickerView.selectedRow(inComponent: 0)]
                    self.dismiss(animated: true) {
                        self.delegate?.callbackCategory(item: item)
                    }
                }
                }else if pickerSelection == .subcat {
                    let path = pickerView.selectedRow(inComponent: 0)
                    if subcats.isset(path){
                        let item = subcats[pickerView.selectedRow(inComponent: 0)]
                        self.dismiss(animated: true) {
                            self.delegate?.callbacksubcat(item: item)
                        }
                    }
                    }else if pickerSelection == .section {
                        let path = pickerView.selectedRow(inComponent: 0)
                        if sections.isset(path){
                            let item = sections[pickerView.selectedRow(inComponent: 0)]
                            self.dismiss(animated: true) {
                                self.delegate?.callbacksection(item: item)
                            }
                        
                        }
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
                formatter.dateFormat = "MM/dd/yyyy"
                let date = formatter.string(from: datePicker.date)
//                datePicker.maximumDate = Date()
                datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())

                self.view.endEditing(true)
                self.dismiss(animated: true) {
                    self.delegate?.callbackDate(item: date, returnedKey: self.returnedKey)
                }
            }else{
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let time = formatter.string(from: datePicker.date)
                datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
//                datePicker.maximumDate = Date()
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
        else if pickerSelection == .category {
            return cats.count
        }else if pickerSelection == .delivary {
            return delevariymethods.count
        }else if pickerSelection == .address {
            return addressdata.count
        }else if pickerSelection == .time {
            return protimes.count
        }
        else if pickerSelection == .subcat {
            return subcats.count
        } else if pickerSelection == .lookup {
            return lookups.count
        } else if pickerSelection == .size {
            return sizes.count
        } else if pickerSelection == .color {
            return colors.count
        }
        else if pickerSelection == .section {
            return sections.count
        }
        else if pickerSelection == .raeson {
            return raesons.count
        }
//        else if pickerSelection == .custom {
//            return customs.count
//        }
        return 0
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1

    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
////        if pickerSelection == .country {
////            return countries[row].name
////        }else
//        if pickerSelection == .city{
//            return cities[row].name
//        }
//        else if pickerSelection == .gender {
//            return genders[row].name
//        }
//        else if pickerSelection == .raeson {
//            return raesons[row].name
//        }
////        else if pickerSelection == .custom {
////            return customs[row].title
////        }
//        
//        return nil
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Muli.ttf", size: 15)
            pickerLabel?.textAlignment = .center
        }
        if pickerSelection == .city{
            pickerLabel?.text = cities[row].name
        }
        else if pickerSelection == .gender {
            pickerLabel?.text = genders[row].name
        }else if pickerSelection == .color {
            pickerLabel?.text = colors[row].name
        }else if pickerSelection == .size {
            pickerLabel?.text = sizes[row].name
        }else if pickerSelection == .lookup {
            pickerLabel?.text = lookups[row].displayName
        }
        else if pickerSelection == .category {
            pickerLabel?.text = cats[row].name
        }
        else if pickerSelection == .section {
            pickerLabel?.text = sections[row].name
        }
        else if pickerSelection == .subcat {
            pickerLabel?.text = subcats[row].name
        }else if pickerSelection == .address {
            pickerLabel?.text = addressdata[row].name
        }else if pickerSelection == .time {
            pickerLabel?.text = protimes[row].name
        }else if pickerSelection == .delivary {
            pickerLabel?.text = delevariymethods[row].name
        }
        else if pickerSelection == .raeson {
            pickerLabel?.text = raesons[row].name
        }
        pickerLabel?.textColor = .gray
        return pickerLabel!
    }
}
