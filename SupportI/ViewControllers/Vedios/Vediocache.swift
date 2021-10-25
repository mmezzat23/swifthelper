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
        if vedioid == "" {
            error = "\(error)\n \("Select vedio".localized)"
        }
        if (error != ""){
          makeAlert(error, closure: {})
        }else{
            parameters["videoId"] = userupload?.id ?? ""
            parameters["urlThumbnail"] = userupload?.urlthumbnail ?? ""
            parameters["urlPreview"] = userupload?.urlPreview ?? ""
            parameters["urlDownload"] = userupload?.urldownload ?? ""

            viewModel?.addvedio(paramters: parameters)

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
        if (durationInSeconds <= 60){
        self.startLoading()
        Wndo.ApiManager.instance.connection(.seginure, type: .get) { (response) in
            let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
            if (data?.isSuccess == true){
                let url = "files/create?&api_signature=\(data?.responseData?.api_signature ?? "")&api_key=\(data?.responseData?.api_key ?? "")&api_nonce=\(data?.responseData?.api_nonce ?? "")&api_timestamp=\(data?.responseData?.api_timestamp ?? "")"
                ApiManager.instance.uploadFilepulitico(url, type: .post, file: [["file": self.videoURL!]]) { [self] (response) in
                                 self.stopLoading()
                                 let data = try? JSONDecoder().decode(UploadModel.self, from: response ?? Data())
                    print(data?.id)
//                    player.isHidden = false
//                    let asset = BMPlayerResource(url: videoURL!,
//                                                 name: "WNDO")
                    userupload = data
//                    player.setVideo(resource: asset)
                    vedioid = data?.id ?? ""
//                    vediothum = data?.urlthumbnail ?? ""
//                    delete.isHidden = false
                                 
                             }
            }else{
                
            }
        }
        }else {
            makeAlert("Vedio must be not exceeded 1 minute".localized(), closure: {})
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
  
