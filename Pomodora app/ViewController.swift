//
//  ViewController.swift
//  Pomodora app
//
//  Created by Tigran on 11/15/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var stopLabel: UIButton!
    
    var timer: Timer!
    var timeRemaining = 15
    var restTime = 3
    var minutes = ""
    var seconds = ""
    var rest = false
    var isWorking = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minutes = String(format: "%02d", timeRemaining/60)
        seconds = String(format: "%02d", timeRemaining%60)
        buttonLabel.setTitle("\(minutes):\(seconds)", for: .normal)
        UIView.setAnimationsEnabled(false)
        stopLabel.setTitle("End Session", for: .normal)
        stopLabel.isHidden = true

    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        stopLabel.isHidden = false
        if !isWorking{
            isWorking = true
            if !rest {
                rest = true
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(workStep), userInfo: nil, repeats: true)
                
            }else {
                rest = false
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(restStep), userInfo: nil, repeats: true)
                
            }

        }else {
            timer.invalidate()
            isWorking = false
        }
    }
    
    @IBAction func stopTapped(_ sender: UIButton) {
        alert()
        
    }
    
    func alert() {
        let alert = UIAlertController(title: "End Session", message: "Do you want to end this session?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler:{ action in
            self.timer.invalidate()
            self.timeRemaining = 15
            self.minutes = String(format: "%02d", self.timeRemaining/60)
            self.seconds = String(format: "%02d", self.timeRemaining%60)
            self.buttonLabel.setTitle("\(self.minutes):\(self.seconds)", for: .normal)
            self.isWorking = false
            self.stopLabel.isHidden = true


        } ))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))

        present(alert,animated: true)
    }
//
    @objc func workStep() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        }else {
            timer.invalidate()
            timeRemaining = restTime
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
        minutes = String(format: "%02d", timeRemaining/60)
        seconds = String(format: "%02d", timeRemaining%60)
        buttonLabel.setTitle("\(minutes):\(seconds)", for: .normal)
    }
    @objc func restStep() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        }else {
            timer.invalidate()
            timeRemaining = 15
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        minutes = String(format: "%02d", timeRemaining/60)
        seconds = String(format: "%02d", timeRemaining%60)
        buttonLabel.setTitle("\(minutes):\(seconds)", for: .normal)
        
    }
    
}

