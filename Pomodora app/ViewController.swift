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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    
    var timer: Timer!
    var timeRemaining = 15
    var restTime = 3
    var minutes = ""
    var seconds = ""
    var count = 0
    var rest = false
    
    
    override func viewDidLoad() {
        countLabel.layer.cornerRadius = 20
        countLabel.backgroundColor = .white
        countLabel.textColor = .black
        countLabel.text = "\(count)"
        super.viewDidLoad()
        
        minutes = String(format: "%02d", timeRemaining/60)
        seconds = String(format: "%02d", timeRemaining%60)
        timeLabel.text = ("\(minutes):\(seconds)")
        UIView.setAnimationsEnabled(false)

    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        switch startButton.titleLabel?.text {
        case "Start":
            startButton.setTitle("Stop", for: .normal)
            if !rest {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(workStep), userInfo: nil, repeats: true)
                rest = true
            }else {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(restStep), userInfo: nil, repeats: true)
                rest = false
                print("isworking else")
            }
        case "Stop":
            startButton.setTitle("Start", for: .normal)
            timer.invalidate()
            rest = !rest
            
        default:
            print("something went wrong")
        }
            
        }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        alert()
        
    }
    
    func alert() {
        let alert = UIAlertController(title: "End Session", message: "Do you want to end this session?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler:{ action in
            self.timer.invalidate()
            self.timeRemaining = 15
            self.minutes = String(format: "%02d", self.timeRemaining/60)
            self.seconds = String(format: "%02d", self.timeRemaining%60)
            self.timeLabel.text = ("\(self.minutes):\(self.seconds)")
            self.startButton.setTitle("Start", for: .normal)
            self.rest = !self.rest
            


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
            startButton.setTitle("Start", for: .normal)
            count += 1
            countLabel.text = "\(count)"
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
        minutes = String(format: "%02d", timeRemaining/60)
        seconds = String(format: "%02d", timeRemaining%60)
        timeLabel.text = ("\(minutes):\(seconds)")
    }
    @objc func restStep() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        }else {
            timer.invalidate()
            timeRemaining = 15
            startButton.setTitle("Start", for: .normal)
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        minutes = String(format: "%02d", timeRemaining/60)
        seconds = String(format: "%02d", timeRemaining%60)
        timeLabel.text = ("\(minutes):\(seconds)")
        
    }
    
}

