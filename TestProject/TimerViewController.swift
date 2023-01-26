//
//  TimerViewController.swift
//  TestProject
//
//  Created by admin on 25.01.2023.
//

import UIKit

class TimerViewController: UIViewController {
    
    var rounds = 1
    var timePerRound = 1
    var withBreak = false
    var TimeForBreak = 1
    
    var timer: Timer!
    
    var isTimerWorking = true
    var isBreak = false {
        didSet {
            if isBreak {
                self.view.backgroundColor = .yellow
            } else {
                self.view.backgroundColor = .green
            }
        }
    }
    var currentTime: Int!
    var currentRound: Int!
    
    
    
    
    @IBOutlet weak var PauseResumeButton: UIButton!
    
    @IBAction func PauseButtonTouched(_ sender: UIButton) {
        timer.invalidate()
        if isTimerWorking {
            
        } else {
            startTimer(time: currentTime)
        }
        isTimerWorking.toggle()
    }
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimeLabel.text = timeToString(timePerRound)
        currentTime = timePerRound
        currentRound = 1
        startTimer(time: timePerRound)
    }
    
    func startTimer(time : Int){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    @objc func step(){
        if currentTime > 0 {
            currentTime -= 1
        } else {
            timer.invalidate()
            if withBreak {
                if isBreak {
                    currentTime = timePerRound
                    startTimer(time: timePerRound)
                    isBreak.toggle()
                } else {
                    if currentRound < rounds {
                        currentRound += 1
                        currentTime = TimeForBreak
                        startTimer(time: TimeForBreak)
                        isBreak.toggle()
                    } else {
                        self.view.backgroundColor = .red
                    }
                }
            } else {
                if currentRound < rounds {
                    currentRound += 1
                    currentTime = timePerRound
                    startTimer(time: timePerRound)
                } else {
                    self.view.backgroundColor = .red
                }
            }
        }
        TimeLabel.text = "\(timeToString(currentTime))"
    }
    
}
