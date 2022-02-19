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
    
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    var timer = Timer()
    var secondsPassed = 0
    var totalTime = 0
    var player : AVAudioPlayer!
    
    @IBOutlet weak var progressVIew: UIProgressView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
       
        progressVIew.progress = 0.0
        secondsPassed = 0
        mainLabel.text = hardness   
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        }
    
    @objc func update () {
        if  secondsPassed < totalTime {
            secondsPassed += 1
            let percentProgressBar = Float(secondsPassed) / Float(totalTime)
            progressVIew.progress = percentProgressBar
        } else {
            timer.invalidate()
            mainLabel.text = "Done"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            }
    }
}
