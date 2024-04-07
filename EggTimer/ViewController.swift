//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes = ["Soft": 5, "Medium": 8, "Hard": 12]
    var timer = Timer()
    var timePassed = 0
    var timeNeeded = 0
    let player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!)
    
    @IBAction func hardnessSelected(_ sender: UIButton){
        topLabel.text = "Preparing your egg your \(sender.currentTitle!) egg..."
        timer.invalidate()
        timeNeeded = eggTimes[sender.currentTitle!]! //* 60
        timePassed = 0
        startTimer()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer(){
        let percentageProgress = Float(timePassed)/Float(timeNeeded)
        print("\(timePassed)/\(timeNeeded) = \(percentageProgress)")
        if timePassed < timeNeeded {
            timePassed += 1
        } else {
            endTimer()
            topLabel.text = "Done!"
        }
        progressBar.setProgress(percentageProgress, animated: true)
    }
    func endTimer() {
        timer.invalidate()
        player.play()
    }

    
}
