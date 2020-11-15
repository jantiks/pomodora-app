//
//  ViewController.swift
//  Pomodora app
//
//  Created by Tigran on 11/15/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var buttonLabel: UIButton!
    
    var timer: Timer!
    var timeRemaining = 15
    var restTime = 3
    var minutes = ""
    var seconds = ""
    var rest = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minutes = String(format: "%02d", timeRemaining/60)
        seconds = String(format: "%02d", timeRemaining%60)
        buttonLabel.setTitle("\(minutes):\(seconds)", for: .normal)
        UIView.setAnimationsEnabled(false)

    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        if !rest {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(workStep), userInfo: nil, repeats: true)
            rest = true
        }else {
             timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(restStep), userInfo: nil, repeats: true)
            rest = false
        }
    }
    
    @objc func workStep() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        }else {
            timer.invalidate()
            timeRemaining = restTime
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
        }
        minutes = String(format: "%02d", timeRemaining/60)
        seconds = String(format: "%02d", timeRemaining%60)
        buttonLabel.setTitle("\(minutes):\(seconds)", for: .normal)
        
    }
    
}

