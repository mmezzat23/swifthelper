//
//  Recordeing.swift
//  Wndo
//
//  Created by Adam on 14/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import KDCircularProgress
import AVFoundation
import Photos
import CameraManager
class Recordeing: BaseController {
   
    var timerHelper: TimeHelper?
    var videoURL: URL?

    @IBOutlet weak var pause: UIImageView!
    @IBOutlet weak var play: UIImageView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var perview: UIView!
    var currentCount = 60
    var maxCount = 60
    var parameters : [String : Any] = [:]
    var userupload : UploadModel?
    var viewModel : SallerViewModel?
    let cameraManager = CameraManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        cameraManager.addPreviewLayerToView(self.perview)
        cameraManager.cameraDevice = .front
        cameraManager.writeFilesToPhoneLibrary = true
        let zoomScale = CGFloat(2.0)
        cameraManager.zoom(zoomScale)
        pause.isHidden = true
        play.UIViewAction { [self] in
            starttime()
            play.isHidden = true
            pause.isHidden = false
            cameraManager.startRecordingVideo()
        }
        pause.UIViewAction { [self] in
            pause.isHidden = true
            play.isHidden = false
            save()
            timerHelper?.stopTimer()
        }
        cameraManager.showErrorBlock = { (erTitle: String, erMessage: String) -> Void in
            var alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            }))

            let topController = UIApplication.shared.keyWindow?.rootViewController

            if (topController != nil) {
                topController?.present(alertController, animated: true, completion: { () -> Void in
                    //
                })
            }

        }
        }
    func setup() {
       viewModel = .init()
       viewModel?.delegate = self
       
    }
    override func bind() {
        viewModel?.userdata.bind({ [weak self](data) in
                self?.stopLoading()
            let controller = UIStoryboard(name: "Saller", bundle: nil).instantiateInitialViewController()
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
    func newAngle() -> Double {
        return Double(0 + ((maxCount - currentCount) * 6))
    }


    @IBAction func record(_ sender: Any) {
        starttime()

    }
    
    func starttime() {
     
        timerHelper = .init(seconds: 1, numberOfCycle: 60, closure: { [weak self] (cycle) in
            self?.timer.text = String(cycle)
            if cycle == 0 {
                self?.currentCount = 0
//                self?.recorder.stopRunning()
                self?.save()
                self?.timerHelper?.stopTimer()
                self?.progress.animate(fromAngle: (self?.progress.angle)!, toAngle: 0, duration: 0.5, completion: nil)

            }else{
                self?.currentCount = cycle
                let newAngleValue = self?.newAngle()
                self?.progress.animate(toAngle: newAngleValue!, duration: 0.5, completion: nil)

            }
        })
    }
    func save () {
        self.startLoading()
        cameraManager.stopVideoRecording({ (videoURL, recordError) -> Void in
            guard let videoURL = videoURL else {
                return
            }
            do {
                Wndo.ApiManager.instance.connection(.seginure, type: .get) { (response) in
                    
                                                                 let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                                                                 if (data?.isSuccess == true){
                                                                     let url = "files/create?&api_signature=\(data?.responseData?.api_signature ?? "")&api_key=\(data?.responseData?.api_key ?? "")&api_nonce=\(data?.responseData?.api_nonce ?? "")&api_timestamp=\(data?.responseData?.api_timestamp ?? "")"
                                                                     ApiManager.instance.uploadFilepulitico(url, type: .post, file: [["file": videoURL]]) { [self] (response) in
                                                                                      self.stopLoading()
                                                                                      let data = try? JSONDecoder().decode(UploadModel.self, from: response ?? Data())
                                                                         print(data?.id)
                                                     //                    player.isHidden = false
                                                     //                    let asset = BMPlayerResource(url: videoURL!,
                                                     //                                                 name: "WNDO")
                                                                         userupload = data
                                                     //
                                                                         parameters["videoId"] = userupload?.id ?? ""
                                                                         parameters["urlThumbnail"] = userupload?.urlthumbnail ?? ""
                                                                         parameters["urlPreview"] = userupload?.urlPreview ?? ""
                                                                         parameters["urlDownload"] = userupload?.urldownload ?? ""
                                                                         viewModel?.addvedio(paramters: parameters)
                                                                                  }
                                                                 }else{
             
                                                                 }
                                                             }

            }
            catch {
                //Handle error occured during copy
            }
        })
    }
            
    }


//
