//
//  Addaddress.swift
//  SupportI
//
//  Created by Adam on 9/27/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Addaddress: BaseController {
    @IBOutlet weak var addressname: UITextField!
    @IBOutlet weak var cars: UIButton!
    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var job: UIButton!
    @IBOutlet weak var web: UIButton!
    @IBOutlet weak var gift: UIButton!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var pinlbl: UILabel!
    @IBOutlet weak var pinimg: UIImageView!
    @IBOutlet weak var city: UIView!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var bulidno: UITextField!
    @IBOutlet weak var landmark: UITextField!
    @IBOutlet weak var defult: UISwitch!
    
    var isedit = false
    var type = ""
    var lat : Double = 0
    var lng : Double = 0
    var cityid = 0
    var id = 0
    var addressstr = ""
    var cities : [ItemCity] = []
    var parameters : [String : Any] = [:]
    var viewModel : ProfileViewModel?
    var isdefult = false
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        onclick()
        pinlbl.setunderline(title: "PIN ON MAP".localized)
        setup()
        bind()
    }
    
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.getcity()
        if (isedit == true){
            viewModel?.getsingleaddress(id: id)
        }
    }
    override func bind() {
        viewModel?.cityData.bind({ [weak self](data) in
            self?.stopLoading()
            self?.cities.append(contentsOf: data.responseData?.items ?? [])
            
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                   guard let nav = controller else { return }
                   let delegate = UIApplication.shared.delegate as? AppDelegate
                   delegate?.window?.rootViewController = nav
           
        })
        viewModel?.singleaddressData.bind({ [weak self](data) in
            self?.stopLoading()
            self?.addressname.text = data.responseData?.name ?? ""
            self?.address.text = data.responseData?.street ?? ""
            self?.citylbl.text = data.responseData?.city?.name ?? ""
            self?.cityid = data.responseData?.id ?? 0
            self?.bulidno.text = String(data.responseData?.buildingNo ?? 0)
            self?.landmark.text = data.responseData?.landMark ?? ""
            self?.addressstr = data.responseData?.location ?? ""
            self?.lat = Double(data.responseData?.lat ?? "") ?? 0
            self?.lng = Double(data.responseData?.long ?? "") ?? 0
            self?.defult.isOn = data.responseData?.isDefault ?? false
            self?.isdefult = data.responseData?.isDefault ?? false
        })
    }
    @IBAction func defult(_ sender: Any) {
        isdefult = !isdefult
        
    }
    
    @IBAction func save(_ sender: Any) {
        if (validateTextFields()){
            var error : String = ""
            
            if (cityid == 0){
                error = "\(error)\n \("select city".localized)"
            }
//            if (!not.isChecked){
//                error = "\(error)\n \("must open notification".localized)"
//            }
            if (type == ""){
                error = "\(error)\n \("Select type of address".localized)"
            }
            
            if (error != ""){
              makeAlert(error, closure: {})
            }else{
                parameters["name"] = addressname.text
                parameters["street"] = address.text
                parameters["type"] = type
                parameters["buildingNo"] = bulidno.text
                parameters["landMark"] = landmark.text
                parameters["cityId"] = cityid
                parameters["isDefault"] = isdefult
                if (lat > 0){
                    parameters["lat"] = String(lat)
                    parameters["long"] = String(lng)
                    parameters["location"] = addressstr
                }
                if (isedit == true){
                    parameters["id"] = id
                    viewModel?.editaddress(paramters: parameters)
                }else{
                    viewModel?.addaddress(paramters: parameters)
                }
                print(parameters)
            }
        }
        
    }
    func validateTextFields() -> Bool {
        addressname.customValidationRules = [RequiredRule()]
        address.customValidationRules = [RequiredRule()]
        bulidno.customValidationRules = [RequiredRule()]
        let validator = Validation(textFields: [addressname , address ,bulidno])
        return validator.success
    }

    func onclick() {
        cars.UIViewAction { [self] in
            cars.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            home.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            cars.tintColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            home.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            type = "1"
        }
        home.UIViewAction { [self] in
            home.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            cars.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            home.tintColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            cars.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            type = "2"
        }
        job.UIViewAction { [self] in
            job.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            home.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            cars.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.tintColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            home.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            cars.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            type = "3"
        }
        web.UIViewAction { [self] in
            web.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            home.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            cars.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.tintColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            home.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            cars.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            type = "4"
        }
        gift.UIViewAction { [self] in
            gift.borderColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            home.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            cars.borderColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            gift.tintColor = UIColor(red: 0xFF, green: 0x0E, blue: 0x34)
            home.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            job.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            web.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            cars.tintColor = UIColor(red: 0x95, green: 0x99, blue: 0xB3)
            type = "5"
        }
        pinlbl.UIViewAction { [self] in
            let vcc = self.pushViewController(mapViewController.self,storyboard: .setting)
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        pinimg.UIViewAction { [self] in
            let vcc = self.pushViewController(mapViewController.self,storyboard: .setting)
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        city.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.cities = cities
            vcc.pickerSelection = .city
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Addaddress : PickersPOPDelegate {
    func callbackCity(item: ItemCity) {
        cityid = item.id ?? 0
        citylbl.text = item.name ?? ""
    }
}
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension Addaddress : SelectLocationDelegate {
    func didSelectLocation(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    func didSelectLocation(address: String?) {
        self.addressstr = address ?? ""
    }
    
    
}
