//
//  Editprofile.swift
//  SupportI
//
//  Created by Adam on 9/26/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Editprofile: BaseController {
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
    var parameters : [String : Any] = [:]

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
        self.genders.append(GenderModel(type: "1", name: "Male".localized()))
        self.genders.append(GenderModel(type: "2", name: "Female".localized()))
        birthdate.UIViewAction { [self] in
            let vcc = self.pushViewController(PickersPOP.self,storyboard: .profile)
            vcc.openWhat = "date"
            vcc.returnedKey = "start"
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
                    }else{
                    self.coverURL = url
                    }
                    
                }
        picker?.onPickImage = { [self] image in
                    if (typeimage == "1"){
                    self.banner.image = image
                    }else{
                    self.banner.image = image
                    }
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
                self?.image.setImage(url: Constants.url + "1/" + (data.responseData?.cover)! ?? "")
            }
            if (data.responseData?.profile != ""){
                self?.image.setImage(url: Constants.url + "1/" + (data.responseData?.profile)! ?? "")
            }
            self?.name.text = data.responseData?.name
            self?.bio.text = data.responseData?.bio
            if (data.responseData?.gender  == 1){
                self?.gendertype.text = "Male".localized()
                self?.type = "1"
            }else if (data.responseData?.gender == 2){
                self?.gendertype.text = "Female".localized()
                self?.type = "2"
            }
            if (data.responseData?.dateOfBirth != "" && data.responseData?.dateOfBirth != nil){
            self?.birthdate.text = data.responseData?.dateOfBirth
            }
            
        })
        viewModel?.editdata.bind({ [weak self](data) in
            self?.stopLoading()
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                   guard let nav = controller else { return }
                   let delegate = UIApplication.shared.delegate as? AppDelegate
                   delegate?.window?.rootViewController = nav
            
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
                if ((imageURL) == nil && (coverURL) == nil){
                    parameters["name"] = name.text
                    parameters["bio"] = bio.text
                    parameters["DateOfBirth"] = date
                    parameters["gender"] = type
                    viewModel?.editprofile(paramters: parameters)
                }else {
                    var parameters1 : [String : Any] = [:]
                    parameters1["name"] = name.text
                    parameters1["bio"] = bio.text
                    parameters1["DateOfBirth"] = date
                    parameters1["gender"] = type
                    ApiManager.instance.paramaters = parameters1
                    self.startLoading()
                                 ApiManager.instance.paramaters = parameters1
                    ApiManager.instance.uploadFile(EndPoint.editprofile.rawValue, type: .post, file: [["profile": self.imageURL] , ["cover": self.coverURL]]) { [self] (response) in
                                     self.stopLoading()
                                     let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                        if (data?.isSuccess == true)
                        {
                            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                                   guard let nav = controller else { return }
                                   let delegate = UIApplication.shared.delegate as? AppDelegate
                                   delegate?.window?.rootViewController = nav
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

extension Editprofile : PickersPOPDelegate {
    func callbackDate(item: String, returnedKey: String) {
        birthdate.text = item
        date = item
    }
    func callbackgenders(item: GenderModel) {
        gendertype.text = item.name
        type = item.type ?? ""
    }
}
