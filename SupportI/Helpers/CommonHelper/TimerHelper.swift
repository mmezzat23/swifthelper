//
//  TimerHelper.swift
//  RedBricks
//
//  Created by Mohamed Abdu on 6/10/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation

class TimeHelper {
    var timerVar: Timer?
    var numberOfCycle: Int?
    var closureTimer: (Int) -> Void = { _ in
    }
    init(seconds: Double, numberOfCycle: Int = 0, closure: @escaping ((Int) -> Void)) {
        self.numberOfCycle = numberOfCycle
        self.closureTimer = closure
        self.runTimer(seconds: seconds, closure: closureTimer)
    }
    init(seconds: Double, numberOfCycle: Int = 0) {
        self.numberOfCycle = numberOfCycle
        self.runTimer(seconds: seconds, closure: closureTimer)
    }
    init(seconds: Double, closure:@escaping ((Int) -> Void)) {
        self.numberOfCycle = nil
        self.closureTimer = closure
        self.runTimer(seconds: seconds, closure: closureTimer)
    }
    @objc func timer() {
        guard let counter = numberOfCycle else {return}
        numberOfCycle = counter-1
        closureTimer(counter)
    }
    @objc func timerWithOutCycle() {
        closureTimer(0)
    }
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func runTimer(seconds: Double, closure:@escaping ((Int) -> Void) ) {
        self.stopTimer()
        startTimer(seconds: seconds)
        closureTimer = closure
        //Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timer), userInfo: nil, repeats: true)
    }
    func startTimer (seconds: Double = 1) {
        if numberOfCycle != nil {
            if timerVar == nil {
                timerVar =  Timer.scheduledTimer(
                    timeInterval: TimeInterval(seconds),
                    target: self,
                    selector: #selector(timer),
                    userInfo: nil,
                    repeats: true)
            }
        } else {
            if timerVar == nil {
                timerVar =  Timer.scheduledTimer(
                    timeInterval: TimeInterval(seconds),
                    target: self,
                    selector: #selector(timerWithOutCycle),
                    userInfo: nil,
                    repeats: true)
            }
        }
    }
    func stopTimer() {
        if timerVar != nil {
            timerVar?.invalidate()
            timerVar = nil
        }
    }
    func secondsTimer(cycle: Int) -> String {
        if cycle <= 0 {
            return ""
        }
        var seconds = 0
        var text = "0"
        if cycle > 60 {
            seconds = cycle - 61
            if seconds < 10 {
                text = "1:0\(String(seconds))"
            } else {
                text = "1:\(String(seconds))"
            }
        } else {
            seconds = cycle - 1
            if seconds < 10 {
                text = "0\(String(seconds))"
            } else {
                text = "\(String(seconds))"
            }
        }
        return text
    }
    static func staticSecondsTimer(cycle: Int) -> String {
        if cycle <= 0 {
            return ""
        }
        var seconds = 0
        var text = "0"
        if cycle > 60 {
            seconds = cycle - 61
            if seconds < 10 {
                text = "1:0\(String(seconds))"
            } else {
                text = "1:\(String(seconds))"
            }
        } else {
            seconds = cycle - 1
            if seconds < 10 {
                text = "0\(String(seconds))"
            } else {
                text = "\(String(seconds))"
            }
        }
        return text
    }

}
