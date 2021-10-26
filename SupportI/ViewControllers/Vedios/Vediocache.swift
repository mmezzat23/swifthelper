//
//  Vediocache.swift
//  Wndo
//
//  Created by Adam on 13/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import BMPlayer
import AVFoundation
class Vediocache: BaseController {
    var parameters : [String : Any] = [:]
    var userupload : UploadModel?
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var vedioid = ""
    var viewModel : SallerViewModel?
    @IBOutlet weak var player: BMPlayer!
    @IBOutlet weak var delete: UIImageView!
    
    @IBOutlet weak var attach: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
      
    }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
        attach.UIViewAction { [self] in
            imagePickerController.sourceType = .savedPhotosAlbum
             imagePickerController.delegate = self
             imagePickerController.mediaTypes = ["public.movie"]
            present(imagePickerController, animated: true, completion: nil)
        }
        delete.UIViewAction { [self] in
            vedioid = ""
            videoURL = nil
            player.isHidden = true
            player.pause()
            delete.isHidden = true
            
        }
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
                self?.stopLoading()
            let controller = UIStoryboard(name: "Saller", bundle: nil).instantiateInitialViewController()
                guard let nav = controller else { return }
                let delegate = UIApplication.shared.delegate as? AppDelegate
                delegate?.window?.rootViewController = nav
            self?.dismiss(animated: true, completion: nil)

        })
       
        viewModel?.errordata.bind({ [weak self](data) in
            self?.stopLoading()
            print(data)
            self?.makeAlert(data, closure: {})
        })
    }
    @IBAction func upload(_ sender: Any) {
        var error : String = ""
        if videoURL == nil {
            error = "\(error)\n \("Select vedio".localized)"
        }
        if (error != ""){
          makeAlert(error, closure: {})
        }else{
            self.startLoading()
            Wndo.ApiManager.instance.connection(.seginure, type: .get) { (response) in
                let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                if (data?.isSuccess == true){
                    let url = "files/create?&api_signature=\(data?.responseData?.api_signature ?? "")&api_key=\(data?.responseData?.api_key ?? "")&api_nonce=\(data?.responseData?.api_nonce ?? "")&api_timestamp=\(data?.responseData?.api_timestamp ?? "")"
                    ApiManager.instance.uploadFilepulitico(url, type: .post, file: [["file": self.videoURL!]]) { [self] (response) in
                                     self.stopLoading()
                                     let data = try? JSONDecoder().decode(UploadModel.self, from: response ?? Data())
                        print(data?.id)
                        parameters["videoId"] = data?.id ?? ""
                        parameters["urlThumbnail"] = data?.urlthumbnail ?? ""
                        parameters["urlPreview"] = data?.urlPreview ?? ""
                        parameters["urlDownload"] = data?.urldownload ?? ""

                        viewModel?.addvedio(paramters: parameters)
          
                                     
                                 }
                }else{
                    
                }
            }
          

        }
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension Vediocache : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            dismiss(animated: true, completion: nil)
            guard let movieUrl = info[.mediaURL] as? URL else { return }
        videoURL = movieUrl
        let asset = AVURLAsset.init(url: videoURL!)
        let durationInSeconds = asset.duration.seconds
        if (durationInSeconds <= 300){
            let asset1 = BMPlayerResource(url: videoURL!,
                                         name: "WNDO")
            player.setVideo(resource: asset1)
            player.isHidden = false
            delete.isHidden = false

        
        }else {
            makeAlert("Vedio must be not exceeded 5 minute".localized(), closure: {})
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
  
