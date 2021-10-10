//
//  Settings.swift
//  SupportI
//
//  Created by Adam on 9/26/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class SettingsProfile: BaseController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailverify: UIButton!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var phoneverify: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordverify: UIButton!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var locationverify: UIButton!
    @IBOutlet weak var languagetxt: UILabel!
    @IBOutlet weak var language: UIView!
    @IBOutlet weak var notification: UIView!
    @IBOutlet weak var notificationtxt: UILabel!
    @IBOutlet weak var darkmode: UIView!
    @IBOutlet weak var darkmodetxt: UILabel!
    @IBOutlet weak var darkmodeswitch: UISwitch!
    @IBOutlet weak var notificatinswitch: UISwitch!
    var lang = ""
    @IBOutlet weak var locationview: UIView!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var phoneview: UIView!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var reasontxt: UILabel!
    @IBOutlet weak var reason: UIView!
    @IBOutlet weak var accountswitch: UISwitch!
    @IBOutlet weak var accounttxt: UILabel!
    @IBOutlet weak var accountactive: UIView!
    var isdark = false
    var isnotication = false
    var isshop = 0
    var isactive = 0
    var cityid = 0
    var viewModel : ProfileViewModel?
    var parameters : [String : Any] = [:]
    var cities : [ItemCity] = []
    var genders : [GenderModel] = []
    var reasontype = ""
    var phonetxt = ""
    var type = ""
    var responseData: Token?
    @IBOutlet weak var editloc: UIImageView!
    @IBOutlet weak var editpass: UIImageView!
    @IBOutlet weak var editphone: UIImageView!
    @IBOutlet weak var editemail: UIImageView!
    @IBOutlet weak var shopswitch: UISwitch!
    @IBOutlet weak var shopstatustxt: UILabel!
    @IBOutlet weak var shopstatustop: NSLayoutConstraint!
    @IBOutlet weak var shopstatushight: NSLayoutConstraint!
    @IBOutlet weak var shopstatus: UIView!
    @IBOutlet var banner: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        if (getAppLang() == "en"){
            languagetxt.text = "English"
        }else {
            languagetxt.text = "العربيه"
        }
        language.UIViewAction {
            changeLang {
                self.lang = Constants.lang
                 if (Constants.lang == "ar"){
                     self.languagetxt.text! = "العربيه"
                 }else {
                     self.languagetxt.text! = "English"
                 }
             }
        }
        if (UserRoot.saller() == false){
            shopstatus.isHidden = true
            shopstatustop.constant = 0
            shopstatushight.constant = 0
        }else {
            banner.backgroundColor = UIColor(red: 01, green: 14, blue: 47)
        }
    }
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.getaccountsetting()
        viewModel?.getcity()
        self.genders.removeAll()
        self.genders.append(GenderModel(type: "1", name: "reason1".localized()))
        self.genders.append(GenderModel(type: "2", name: "reason2".localized()))
        locationview.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.cities = cities
            vcc.pickerSelection = .city
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        reason.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.genders = genders
            vcc.pickerSelection = .gender
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        editphone.UIViewAction { [self] in
            type = "phone"
            let vcc = self.pushViewController(Editemail.self,storyboard: .profile)
            vcc.cities = cities
            vcc.type = type
            vcc.responseData = responseData
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        editemail.UIViewAction { [self] in
            type = "email"
            let vcc = self.pushViewController(Editemail.self,storyboard: .profile)
            vcc.cities = cities
            vcc.type = type
            vcc.responseData = responseData
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        editloc.UIViewAction { [self] in
            type = "loc"
            let vcc = self.pushViewController(Editemail.self,storyboard: .profile)
            vcc.cities = cities
            vcc.type = type
            vcc.responseData = responseData
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            self?.responseData = data.responseData
            self?.email.text = data.responseData?.email
            self?.phone.text = data.responseData?.phone
            self?.phonetxt = data.responseData?.phone ?? ""
            self?.password.placeholder = "********"
            self?.darkmodeswitch.isOn = data.responseData?.isDarkMode ?? false
            self?.notificatinswitch.isOn = data.responseData?.isNotificationOn ?? false
            if (data.responseData?.status ?? 0 == 1){
                self?.accountswitch.isOn = true
                self?.accounttxt.text = "Active".localized()
            }else {
                self?.accountswitch.isOn = false
                self?.notificationtxt.text = "Notactive".localized()
            }
            
            self?.isdark = data.responseData?.isDarkMode ?? false
            self?.isnotication = data.responseData?.isNotificationOn ?? false
            self?.isactive = data.responseData?.status ?? 0
            if (self?.isdark == true){
                self?.darkmodetxt.text = "On".localized()
            }else{
                self?.darkmodetxt.text = "Off".localized()
            }
            if (self?.isnotication == true){
                self?.notificationtxt.text = "On".localized()
            }else{
                self?.notificationtxt.text = "Off".localized()
            }
            if (data.responseData?.city?.id ?? 0 > 0){
                self?.cityid = data.responseData?.city?.id ?? 0
                self?.location.text = data.responseData?.city?.name ?? ""
            }
            
        })
        viewModel?.deleteaccount.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data.responseData ?? "", closure: {
                let vcc = self?.pushViewController(Passworddelete.self,storyboard: .profile)
                self?.pushPop(vcr: vcc!)
            })
        })
        viewModel?.verifyphone.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data.responseData ?? "", closure: {
                let vcc = self?.pushViewController(CodeverficationController.self,storyboard: .auth1)
                vcc?.delegate = self
                vcc?.isverify = true
                self?.pushPop(vcr: vcc!)
            })
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
        viewModel?.cityData.bind({ [weak self](data) in
            self?.stopLoading()
            self?.cities.append(contentsOf: data.responseData?.items ?? [])
            
        })
        viewModel?.editdata.bind({ [weak self](data) in
            if (self?.type == ""){
                self?.stopLoading()
                if (self?.lang == "ar"){
                    setAppLang(.arabic)
                }else{
                    setAppLang(.english)
                }
                Localizer.initLang()
                if (self?.isdark == true){
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                       return
                    }
                    appDelegate.changeTheme(themeVal: "dark")
                    UserRoot.savemode(remember: "dark")
                }else{
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                       return
                    }
                    UserRoot.savemode(remember: "light")
                    appDelegate.changeTheme(themeVal: "light")
                }
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                       guard let nav = controller else { return }
                       let delegate = UIApplication.shared.delegate as? AppDelegate
                       delegate?.window?.rootViewController = nav
            }else {
                let vcc = self?.pushViewController(Changesuccess.self,storyboard: .profile)
                vcc?.delegate = self
                self?.pushPop(vcr: vcc!)
            }
            
        })
    }
    @IBAction func deleteaccount(_ sender: Any) {
        if (reasontype == ""){
            makeAlert("Select reason of delete", closure: {})
        }else{
            viewModel?.deleteaccountapi(reason: reasontype)
        }
    }
    @IBAction func save(_ sender: Any) {
        var error : String = ""
        if (cityid == 0){
            error = "\(error)\n \("select city".localized)"
        }
        if (error != ""){
          makeAlert(error, closure: {})
        }else{
        if (phonetxt == phone.text){
        parameters["email"] = email.text
        parameters["phone"] = phone.text
        parameters["cityId"] = cityid
        parameters["isNotificationOn"] = isnotication
        parameters["status"] = isactive
        parameters["isDarkMode"] = isdark
        if (password.text != ""){
            parameters["password"] = password.text
        }
        viewModel?.editaccountsetting(paramters: parameters)
        }else{
            viewModel?.verfiyaccountsetting(phone: phone.text ?? "")
        }
        }
        print(parameters)
    }
    @IBAction func accountactive(_ sender: Any) {
        if (isactive == 1){
            isactive = 0
            accounttxt.text = "Notactive".localized()
        }else {
            isactive = 1
            accounttxt.text = "Active".localized()
        }
    }
    @IBAction func darkmode(_ sender: Any) {
        isdark = !isdark
        if (isdark == true){
            darkmodetxt.text = "On".localized()
        }else{
            darkmodetxt.text = "Off".localized()
        }
    }
    
    @IBAction func shop(_ sender: Any) {
        if (isshop == 1){
            isshop = 0
            shopstatustxt.text = "Notactive".localized()
        }else {
            isshop = 1
            shopstatustxt.text = "Active".localized()
        }
    }
    @IBAction func notifiy(_ sender: Any) {
        isnotication = !isnotication
        if (isnotication == true){
           notificationtxt.text = "On".localized()
        }else{
            notificationtxt.text = "Off".localized()
        }
    }
    @IBAction func locationverify(_ sender: Any) {
    }
    @IBAction func phoneverify(_ sender: Any) {
    }
    @IBAction func emailverify(_ sender: Any) {
    }
    
    @IBAction func passwordverify(_ sender: Any) {
    }
    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            // Perform action.
        }
    }

}
extension SettingsProfile : PickersPOPDelegate {
    func callbackCity(item: ItemCity) {
        cityid = item.id ?? 0
        location.text = item.name ?? ""
    }
    func callbackgenders(item: GenderModel) {
        reasontxt.text = item.name
        reasontype = item.type ?? ""
    }
}
extension SettingsProfile : EditemailDelegate {
    func settype(type: String) {
        if (type == "loc"){
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                let vcc = self.pushViewController(Changesuccess.self,storyboard: .profile)
                vcc.delegate = self
                self.pushPop(vcr: vcc)
            }
           
        }else if (type == "phone"){
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                let vcc = self.pushViewController(CodeverficationController.self,storyboard: .auth1)
                vcc.delegate = self
                vcc.isverify = true
                vcc.type = "phone"
                self.push(vcc)
            }
           
        }else {
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){ [self] in
                let vcc = self.pushViewController(CodeverficationController.self,storyboard: .auth1)
                vcc.delegate = self
                vcc.isverify = true
                vcc.type = "email"
                self.push(vcc)
            }
        }
    }
}
extension SettingsProfile : PhoneverifyDelegate {
    func verify(item: Bool , type : String) {
        if (item == true){
            if (type == "phone") {
                parameters["phone"] = phone.text
            }else {
                parameters["email"] = email.text
            }
            parameters["cityId"] = cityid
            viewModel?.editaccountsetting(paramters: parameters)
            
        }
    }
}


extension SettingsProfile : ChangesuccessDelegate {
    func settype() {
        type = ""
        viewModel?.getaccountsetting()
    }
}
