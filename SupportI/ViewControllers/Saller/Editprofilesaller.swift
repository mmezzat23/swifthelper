//
//  Editprofilesaller.swift
//  Wndo
//
//  Created by Adam on 10/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Editprofilesaller: BaseController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var bio: UITextField!
    @IBOutlet weak var reminder: UILabel!
    @IBOutlet weak var gender: UIView!
    @IBOutlet weak var gendertype: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    @IBOutlet weak var banner: UIImageView!
    var viewModel : AuthViewModel?
    var genders : [GenderModel] = []
    var type = ""
    var date = ""
    var typeimage = ""
    var picker: GalleryPickerHelper?
    var imageURL: URL?
    var coverURL: URL?
    var idURL: URL?
    var parameters : [String : Any] = [:]

    @IBOutlet weak var seesamole: UILabel!
    @IBOutlet weak var notactive: UIView!
    @IBOutlet weak var idimage: UIImageView!
    @IBOutlet weak var idclick: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
    }
    
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.getprofile()
        self.genders.removeAll()
        self.genders.append(GenderModel(type: "0", name: "Male".localized()))
        self.genders.append(GenderModel(type: "1", name: "Female".localized()))
        birthdate.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "date"
            vcc.returnedKey = "start"
            vcc.date = date
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        gender.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "picker"
            vcc.genders = genders
            vcc.pickerSelection = .gender
            vcc.delegate = self
            pushPop(vcr: vcc)
        }
        picker = .init()
        picker?.onPickImageURL = { [self] url in
                    if (typeimage == "1"){
                    self.imageURL = url
                    }else if (typeimage == "3"){
                        self.idURL = url
                    }else{
                    self.coverURL = url
                    }
                    
                }
        picker?.onPickImage = { [self] image in
                    if (typeimage == "1"){
                    self.image.image = image
                    }else  if (typeimage == "3"){
                        self.idimage.image = image
                     }else{
                    self.banner.image = image
                    }
                }
        idclick.UIViewAction {
            self.typeimage = "3"
            self.picker?.pick(in: self)
        }
        seesamole.UIViewAction { [self] in
            let vcc = self.pushViewController(Samplesaller.self,storyboard: .saller)
            pushPop(vcr: vcc)
        }
    }
    func validateTextFields() -> Bool {
        name.customValidationRules = [RequiredRule()]
        bio.customValidationRules = [RequiredRule()  , MaxLengthRule(length: 180)]
        let validator = Validation(textFields: [name , bio])
        return validator.success
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
            self?.stopLoading()
            if (data.responseData?.cover != ""){
                self?.banner.setImage(url: data.responseData?.cover)
            }
            if (data.responseData?.profile != ""){
                self?.image.setImage(url: data.responseData?.profile)
            }
            if (data.responseData?.picWithId != ""){
                self?.idimage.setImage(url: data.responseData?.picWithId)
            }
            if (data.responseData?.isActiveSeller == true){
                self?.notactive.isHidden = true
            }
            self?.name.text = data.responseData?.name
            self?.bio.text = data.responseData?.bio
            if (data.responseData?.gender  == 0){
                self?.gendertype.text = "Male".localized()
                self?.type = "0"
            }else if (data.responseData?.gender == 1){
                self?.gendertype.text = "Female".localized()
                self?.type = "1"
            }
            if (data.responseData?.dateOfBirth != "" && data.responseData?.dateOfBirth != nil){
                self?.date = data.responseData?.dateOfBirth ?? ""
            self?.birthdate.text = data.responseData?.dateOfBirth
            }
            
        })
        viewModel?.editdata.bind({ [weak self](data) in
            self?.stopLoading()
            let vcc = self?.pushViewController(Changesuccess.self,storyboard: .profile)
            vcc?.delegate = self
            self?.pushPop(vcr: vcc!)
        })
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    @IBAction func editbanner(_ sender: Any) {
        typeimage = "2"
        self.picker?.pick(in: self)
    }
    @IBAction func save(_ sender: Any) {
        if (validateTextFields()){
            var error : String = ""
            
            if (type == ""){
                error = "\(error)\n \("select gender".localized)"
            }
//            if (!not.isChecked){
//                error = "\(error)\n \("must open notification".localized)"
//            }
            if (date == ""){
                error = "\(error)\n \("Select birthdate".localized)"
            }
            
            if (error != ""){
              makeAlert(error, closure: {})
            }else{
                let inputFormatter = DateFormatter()
                inputFormatter.dateFormat = "MM/dd/yyyy"
                let showDate = inputFormatter.date(from: date)
                inputFormatter.dateFormat = "yyyy/MM/dd"
                let resultString = inputFormatter.string(from: showDate!)
                if ((imageURL) == nil && (coverURL) == nil && (idURL) == nil){
                    parameters["name"] = name.text
                    parameters["bio"] = bio.text
                    parameters["DateOfBirth"] = resultString
                    parameters["gender"] = type
                    viewModel?.editprofile(paramters: parameters)
                }else {
                    var parameters1 : [String : Any] = [:]
                    parameters1["name"] = name.text
                    parameters1["bio"] = bio.text
                    parameters1["DateOfBirth"] = resultString
                    parameters1["gender"] = type
                    ApiManager.instance.paramaters = parameters1
                    self.startLoading()
                                 ApiManager.instance.paramaters = parameters1
                    ApiManager.instance.uploadFile(EndPoint.editprofile.rawValue, type: .post, file: [["profile": self.imageURL] , ["cover": self.coverURL] , ["picWithId": self.idURL]]) { [self] (response) in
                                     self.stopLoading()
                                     let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                        if (data?.isSuccess == true)
                        {
                            let vcc = self.pushViewController(Changesuccess.self,storyboard: .profile)
                            vcc.delegate = self
                            self.pushPop(vcr: vcc)
                        }
                        else {
                            makeAlert((data?.errorMessage)!, closure: {})
                        }
                                     
                                 }
                }
            }
        }
    }
    
    @IBAction func editphoto(_ sender: Any) {
        typeimage = "1"
        self.picker?.pick(in: self)
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

extension Editprofilesaller : PickersPOPDelegate {
    func callbackDate(item: String, returnedKey: String) {
        birthdate.text = item
        date = item
    }
    func callbackgenders(item: GenderModel) {
        gendertype.text = item.name
        type = item.type ?? ""
    }
}
extension Editprofilesaller : ChangesuccessDelegate {
    func settype() {
        self.navigationController?.popViewController()
    }
}
