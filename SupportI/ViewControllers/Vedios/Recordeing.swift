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
protocol RecordeingDelegate: class {
    func setuserrecord(userupload : UploadModel?)
}
class Recordeing: BaseController {
   
    var timerHelper: TimeHelper?
    var videoURL: URL?
    var isproduct = false
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    @IBOutlet weak var pause: UIImageView!
    @IBOutlet weak var play: UIImageView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var perview: UIView!
    var currentCount = 300
    var maxCount = 300
    var parameters : [String : Any] = [:]
    var userupload : UploadModel?
    var viewModel : SallerViewModel?
    let cameraManager = CameraManager()
    var delegate : RecordeingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        bind()
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (allowedAccess) -> Void in
            
                AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: { (allowedAccess) -> Void in
                    DispatchQueue.main.async { () -> Void in
                    }
                })
            
        })
        cameraManager.addPreviewLayerToView(self.perview)
        cameraManager.cameraDevice = .front
        cameraManager.writeFilesToPhoneLibrary = true
        cameraManager.videoStabilisationMode = .auto
        cameraManager.activeVideoStabilisationMode
        cameraManager.shouldEnableExposure = true
//        cameraManager.showAccessPermissionPopupAutomatically = false
        cameraManager.resetOrientation()
        cameraManager.resumeCaptureSession()


        timer.text = "\(currentCount)"
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
    func requestCameraPermission() {
       AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
           guard accessGranted == true else { return }
        })
    }
    
    @IBAction func back(_ sender: UIButton) {
        if (isproduct == true){
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController()
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
        if (isproduct == true){
        return Double(0 + ((maxCount - currentCount) * 6))
        }else {
            return Double(0 + ((maxCount - currentCount) * 6 / 5))
        }
    }


    @IBAction func record(_ sender: Any) {
        starttime()

    }
    
    func starttime() {
     
        timerHelper = .init(seconds: 1, numberOfCycle: self.currentCount ?? 0, closure: { [weak self] (cycle) in
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
      
        cameraManager.stopVideoRecording({ [self] (videoURL, recordError) -> Void in
            guard let videoURL = videoURL else {
                print(videoURL)
                return
            }
            do {
                makeAlert("are you sure that upload vedio".localized(), closure: {
                    Wndo.ApiManager.instance.connection(.seginure, type: .get) { (response) in
                        
                                                                     let data = try? JSONDecoder().decode(UserRoot.self, from: response ?? Data())
                                                                     if (data?.isSuccess == true){
                                                                         let url = "files/create?&api_signature=\(data?.responseData?.api_signature ?? "")&api_key=\(data?.responseData?.api_key ?? "")&api_nonce=\(data?.responseData?.api_nonce ?? "")&api_timestamp=\(data?.responseData?.api_timestamp ?? "")"
                                                                         ApiManager.instance.uploadFilepulitico(url, type: .post, file: [["file": videoURL]]) { [self] (response) in
                                                                                          self.stopLoading()
                                                                                          let data = try? JSONDecoder().decode(UploadModel.self, from: response ?? Data())
                                                                             print(data?.urlPreview ?? "")
                                                                             userupload = data
                                                         //                    player.isHidden = false
                                                         //                    let asset = BMPlayerResource(url: videoURL!,
                                                         //                                                 name: "WNDO")
                                                                             if (isproduct == true){
                                                                                 delegate?.setuserrecord(userupload: userupload)
                                                                                 self.dismiss(animated: true, completion: nil)
                                                                             }else{
                                                                                 userupload = data
                                                             //
                                                                                 parameters["videoId"] = userupload?.id ?? ""
                                                                                 parameters["urlThumbnail"] = userupload?.urlthumbnail ?? ""
                                                                                 parameters["urlPreview"] = userupload?.urlPreview ?? ""
                                                                                 parameters["urlDownload"] = userupload?.urldownload ?? ""
                                                                                 viewModel?.addvedio(paramters: parameters)
                                                                             }
                                                                                      }
                                                                     }else{
                 
                                                                     }
                                                                 }

                })
            }
            catch {
                //Handle error occured during copy
            }
        })
    }
            
    }


//
