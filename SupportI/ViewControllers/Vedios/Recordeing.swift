//
//  Recordeing.swift
//  Wndo
//
//  Created by Adam on 14/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import SCRecorder
import KDCircularProgress
class Recordeing: BaseController {
    var session = SCRecordSession()
    let recorder = SCRecorder()
    var timerHelper: TimeHelper?

    @IBOutlet weak var pause: UIImageView!
    @IBOutlet weak var play: UIImageView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var perview: UIView!
    var currentCount = 60
    var maxCount = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!recorder.startRunning()) {
                debugPrint("Recorder error: ", recorder.error)
            }
            
            recorder.session = session
            recorder.device = AVCaptureDevice.Position.front
        recorder.videoConfiguration.size = CGSize(width: 800,height: 800)
        recorder.delegate = self
        pause.isHidden = true
        play.UIViewAction { [self] in
            starttime()
            play.isHidden = true
            pause.isHidden = false

        }
        pause.UIViewAction { [self] in
            pause.isHidden = true
            play.isHidden = false
            recorder.pause()
            timerHelper?.stopTimer()
        }
        }

    func newAngle() -> Double {
        return Double(0 + ((maxCount - currentCount) * 6))
    }
        override func viewDidLayoutSubviews() {
            recorder.previewView = perview
        }

    @IBAction func record(_ sender: Any) {
        recorder.record()
        starttime()

    }
    func starttime() {
     
        timerHelper = .init(seconds: 1, numberOfCycle: 60, closure: { [weak self] (cycle) in
            self?.timer.text = String(cycle)
            if cycle == 0 {
                self?.currentCount = 0
                self?.progress.animate(fromAngle: (self?.progress.angle)!, toAngle: 0, duration: 0.5, completion: nil)

            }else{
                self?.currentCount = cycle
                let newAngleValue = self?.newAngle()
                self?.progress.animate(toAngle: newAngleValue!, duration: 0.5, completion: nil)

            }
        })
    }
    func save () {
        session.mergeSegments(usingPreset: AVAssetExportPresetHighestQuality) { (url, error) in
                if (error == nil) {
                    print("zzz" )
//                    url?.saveToCameraRollWithCompletion({ (path, error) in
//                        debugPrint(path, error)
//                    })
                } else {
                    debugPrint("sssss" )
                }
            }
    }
}
extension Recordeing: SCRecorderDelegate {
    
    func recorder(recorder: SCRecorder, didAppendVideoSampleBufferInSession session: SCRecordSession) {
        self.session = session
    }
    
    func updateTimeText(session: SCRecordSession) {
    }
}
