//
//  Addproductmedia.swift
//  Wndo
//
//  Created by Adam on 19/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import BMPlayer
class Addproductmedia: BaseController {
    @IBOutlet weak var viewvedio: UIView!
    @IBOutlet weak var play: UIImageView!
    @IBOutlet weak var player: BMPlayer!
    
    @IBOutlet weak var addvediolbl: UILabel!
    @IBOutlet weak var continu: UIButton!
    @IBOutlet weak var savedraft: UIButton!
    @IBOutlet weak var vediohight: NSLayoutConstraint!
    @IBOutlet weak var vedioline: UIView!
    @IBOutlet weak var vediolinehight: NSLayoutConstraint!
    @IBOutlet weak var vedios: UICollectionView!
    @IBOutlet weak var photos: UICollectionView!
    @IBOutlet weak var delete: UIImageView!
    var productid = ""
    var selectedImages: [UIImage] = []
    var selectedImagesURL: [URL] = []
    var picker: GalleryPickerHelper?
    var parameters : [String : Any] = [:]
    var viewModel : SallerViewModel?
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var isedit = false
    var vedioid = ""
    var catid = 0
    var vediothum = ""
    var selectedImagesString: [UploadModel] = []
    var userupload : UploadModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
//        if (videoURL == nil){
//            play.isHidden = true
//        }
        if (isedit == false){
            vedioline.isHidden = true
            vediolinehight.constant = 0
            vedios.isHidden = true
            vediohight.constant = 0
            addvediolbl.isHidden = true
        }
//        68d372bc-8e2d-46cf-ab3d-7c8607c9e1bb
        // Do any additional setup after loading the view.
    }
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        photos.delegate = self
        photos.dataSource = self
        picker = .init()
        picker?.onPickImageURL = { [self] url in
            selectedImagesURL.append(url!)
                    addimage(file: url!)
                }
        picker?.onPickImage = { [self] image in
            selectedImages.append(image)
            photos.reloadData()
                }
        viewvedio.UIViewAction { [self] in
            imagePickerController.sourceType = .savedPhotosAlbum
             imagePickerController.delegate = self
             imagePickerController.mediaTypes = ["public.movie"]
            present(imagePickerController, animated: true, completion: nil)
        }
        delete.UIViewAction { [self] in
            deletevedio()
        }
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
                self?.stopLoading()
                let vcc = self?.pushViewController(Addproductstep1.self,storyboard: .addproduct)
                vcc?.productid = data.responseData?.productId ?? ""
                vcc?.catid = self?.catid ?? 0
                self?.push(vcc!)
        })
       
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    @IBAction func `continue`(_ sender: Any) {
        var error : String = ""
        if vedioid == "" {
            error = "\(error)\n \("Select vedio".localized)"
        }
        if selectedImagesString.count == 0 {
            error = "\(error)\n \("Select at least one image".localized)"
        }
        
        if (error != ""){
          makeAlert(error, closure: {})
        }else{
            let jsonObject: [String: Any] = [
                "videoId": userupload?.id ?? "",
                "urlThumbnail": userupload?.urlthumbnail ?? "",
                "urlPreview": userupload?.urlPreview ?? "",
                "urlDownload": userupload?.urldownload ?? ""
            ]

        parameters["productId"] = productid
            var images : [[String: Any]] = []
            for item in selectedImagesString {
                let jsonObject: [String: Any] = [
                    "imageId": item.id ?? "",
                    "urlThumbnail": item.urlthumbnail ?? "",
                    "urlPreview": item.urlPreview ?? "",
                    "urlDownload": item.urldownload ?? ""
                ]
                images.append(jsonObject)
            }
        parameters["images"] = images
        parameters["video"] = jsonObject
        print(parameters)

//            if (isedit == true){
//                parameters["id"] = id
//                viewModel?.editcard(paramters: parameters)
//            }else{
            viewModel?.addscreen2(paramters: parameters)
//            }
        }
    }
    
    @IBAction func savedraft(_ sender: Any) {
        var error : String = ""
        if vedioid == "" {
            error = "\(error)\n \("Select vedio".localized)"
        }
        if selectedImagesString.count == 0 {
            error = "\(error)\n \("Select at least one image".localized)"
        }
        
        if (error != ""){
          makeAlert(error, closure: {})
        }else{
            let jsonObject: [String: Any] = [
                "videoId": userupload?.id ?? "",
                "urlThumbnail": userupload?.urlthumbnail ?? "",
                "urlPreview": userupload?.urlPreview ?? "",
                "urlDownload": userupload?.urldownload ?? ""
            ]

        parameters["productId"] = productid
            var images : [[String: Any]] = []
            for item in selectedImagesString {
                let jsonObject: [String: Any] = [
                    "imageId": item.id ?? "",
                    "urlThumbnail": item.urlthumbnail ?? "",
                    "urlPreview": item.urlPreview ?? "",
                    "urlDownload": item.urldownload ?? ""
                ]
                images.append(jsonObject)
            }
        parameters["images"] = images
        parameters["video"] = jsonObject
        print(parameters)

//            if (isedit == true){
//                parameters["id"] = id
//                viewModel?.editcard(paramters: parameters)
//            }else{
            viewModel?.addscreen2(paramters: parameters)
//            }
        }
    }
    func deletevedio() {
        self.startLoading()
        Wndo.ApiManager.instance.connection(.seginure, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true){
                let url = "files/delete/\(self.vedioid)?&api_signature=\(data?.responseData?.api_signature ?? "")&api_key=\(data?.responseData?.api_key ?? "")&api_nonce=\(data?.responseData?.api_nonce ?? "")&api_timestamp=\(data?.responseData?.api_timestamp ?? "")"
                ApiManager.instance.connectionpuliciti(url, type: .delete) { [self] (response) in
                                 self.stopLoading()
                                 let data = try? JSONDecoder().decode(UploadModel.self, from: response ?? Data())
                    print(data?.id)
                    player.isHidden = false
                    let asset = BMPlayerResource(url: videoURL!,
                                                 name: "WNDO")
                    player.setVideo(resource: asset)
                    vedioid = ""
                    vediothum = ""
                    videoURL = nil
                    player.isHidden = true
                    delete.isHidden = true

                                 
                             }
            }else{
                
            }
        }
    }
    func deleteiamge(path : Int) {
        self.startLoading()
        Wndo.ApiManager.instance.connection(.seginure, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true){
                let url = "files/delete/\(self.selectedImagesString[path])?&api_signature=\(data?.responseData?.api_signature ?? "")&api_key=\(data?.responseData?.api_key ?? "")&api_nonce=\(data?.responseData?.api_nonce ?? "")&api_timestamp=\(data?.responseData?.api_timestamp ?? "")"
                ApiManager.instance.connectionpuliciti(url, type: .delete) { [self] (response) in
                                 self.stopLoading()
                                 let data = try? JSONDecoder().decode(UploadModel.self, from: response ?? Data())
                    print(data?.id)
                    selectedImages.remove(at: path)
                    selectedImagesURL.remove(at: path)
                    selectedImagesString.remove(at: path)

                    photos.reloadData()

                                 
                             }
            }else{
                
            }
        }
    }
    func addimage(file : URL) {
        self.startLoading()
        Wndo.ApiManager.instance.connection(.seginure, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true){
                let url = "files/create?&api_signature=\(data?.responseData?.api_signature ?? "")&api_key=\(data?.responseData?.api_key ?? "")&api_nonce=\(data?.responseData?.api_nonce ?? "")&api_timestamp=\(data?.responseData?.api_timestamp ?? "")"
                ApiManager.instance.uploadFilepulitico(url, type: .post, file: [["file": file]]) { [self] (response) in
                                 self.stopLoading()
                                 let data = try? JSONDecoder().decode(UploadModel.self, from: response ?? Data())
                    print(data?.id)
                    selectedImagesString.append(data!)
                                 
                             }
            }else{
                
            }
        }
    }
}
extension Addproductmedia: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:  120 , height: self.photos.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.cell(type: ImagesCollectionViewCell.self, indexPath)
        cell.model = selectedImages[safe: indexPath.row]
        cell.delete.UIViewAction { [self] in
            deleteiamge(path: indexPath.row)
        }
        if (indexPath.row == selectedImages.count){
            cell.image.borderColor = .clear
            cell.image.borderWidth = 0
            cell.delete.isHidden = true
            cell.image?.cornerRadius = 0
        }
        cell.image.UIViewAction { [self] in
            if (indexPath.row == selectedImages.count){
                self.picker?.pick(in: self)
            }
        }
        return cell
    }
    
}
extension Addproductmedia : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            dismiss(animated: true, completion: nil)
            guard let movieUrl = info[.mediaURL] as? URL else { return }
        videoURL = movieUrl
     
        self.startLoading()
        Wndo.ApiManager.instance.connection(.seginure, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true){
                let url = "files/create?&api_signature=\(data?.responseData?.api_signature ?? "")&api_key=\(data?.responseData?.api_key ?? "")&api_nonce=\(data?.responseData?.api_nonce ?? "")&api_timestamp=\(data?.responseData?.api_timestamp ?? "")"
                ApiManager.instance.uploadFilepulitico(url, type: .post, file: [["file": self.videoURL!]]) { [self] (response) in
                                 self.stopLoading()
                                 let data = try? JSONDecoder().decode(UploadModel.self, from: response ?? Data())
                    print(data?.id)
                    player.isHidden = false
                    let asset = BMPlayerResource(url: videoURL!,
                                                 name: "WNDO")
                    userupload = data
                    player.setVideo(resource: asset)
                    vedioid = data?.id ?? ""
                    vediothum = data?.urlthumbnail ?? ""
                    delete.isHidden = false
                                 
                             }
            }else{
                
            }
        }
        
    }
//        self.indicatorView.startAnimating()
//        Publitio.shared.filesCreateWithCompression(localMediaPath: videoURL, videoQuality: .quality960x540, mimeType: .mov, fileUrl: nil, publicId: nil, title: nil, description: nil, tags: nil, privacy: nil, optionDownload: nil, optionTransform: nil, optionAd: nil, completion: { (success, result) in
//                            DispatchQueue.main.async {
//                                print(success,result)
//                                print(result)
//                                self.indicatorView.stopAnimating()
//                               // playCompressedVideo(compressedObj: res)
//                            }
//                        })


            // work with the video URL
}
  