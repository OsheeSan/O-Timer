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
                timeStoped()
            } else {
                timeStarted()
            }
        }
    }
    var currentTime: Int!
    var currentRound: Int!
    
    @IBOutlet weak var PauseResumeButton: UIButton!
    @IBOutlet weak var ActivityView: UIView!
    @IBOutlet weak var TimeLabel: UILabel!
    
    
    @IBAction func PauseButtonTouched(_ sender: UIButton) {
        timer.invalidate()
        if isTimerWorking {
            PauseResumeButton.setTitle("Resume", for: .normal)
            self.view.backgroundColor = .gray
        } else {
            PauseResumeButton.setTitle("Pause", for: .normal)
            if isBreak{
                self.view.backgroundColor = .yellow
            } else {
                self.view.backgroundColor = .green
            }
            startTimer(time: currentTime)
        }
        isTimerWorking.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimeLabel.text = timeToString(5)
        activateProximitySensor(isOn: false)
        getReady()
        startReadyTimer(time: currentTime)
    }
    
    func activateProximitySensor(isOn: Bool) {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = isOn
        if isOn {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityStateDidChange), name: UIDevice.proximityStateDidChangeNotification, object: device)
        } else {
            NotificationCenter.default.removeObserver(self, name: UIDevice.proximityStateDidChangeNotification, object: device)
        }
    }
    
    var proximity = true
    
    @objc func proximityStateDidChange(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            if self.view.viewWithTag(2)?.isHidden == false && proximity{
                PauseButtonTouched(PauseResumeButton)
                proximity = false
            } else {
                proximity = true
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        activateProximitySensor(isOn: false)
    }
    
    func startTimer(time : Int){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
        
    
    func startReadyTimer(time : Int){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ready), userInfo: nil, repeats: true)
    }
    
    @objc func ready(){
        if currentTime > 0 {
            currentTime -= 1
        } else {
            timer.invalidate()
            currentTime = timePerRound
            timeStarted()
            startTimer(time: currentTime)
        }
        TimeLabel.text = "\(timeToString(currentTime))"
        Vibration.heavy.vibrate()
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
                       timeEnded()
                    }
                }
            } else {
                if currentRound < rounds {
                    currentRound += 1
                    currentTime = timePerRound
                    startTimer(time: timePerRound)
                } else {
                    timeEnded()
                }
            }
        }
        TimeLabel.text = "\(timeToString(currentTime))"
    }
    
    func getReady(){
        let activityLabel = ActivityView.viewWithTag(1) as! UILabel
        activityLabel.text = "Get Ready"
        self.view.backgroundColor = .yellow
        self.navigationController?.navigationBar.tintColor = .black
        self.view.viewWithTag(2)?.isHidden = true
        TimeLabel.textColor = .black
        currentTime = 5
        currentRound = 1
        self.view.viewWithTag(2)?.clipsToBounds = true
        self.view.viewWithTag(2)?.layer.cornerRadius = 20
    }
    
    func timeEnded(){
        let activityLabel = ActivityView.viewWithTag(1) as! UILabel
        activityLabel.text = "End"
        self.view.backgroundColor = .red
        self.navigationController?.navigationBar.tintColor = .white
        self.view.viewWithTag(2)?.isHidden = true
        TimeLabel.textColor = .white
        activateProximitySensor(isOn: false)
        Vibration.error.vibrate()
    }
    
    func timeStarted(){
        activateProximitySensor(isOn: false)
        let activityLabel = ActivityView.viewWithTag(1) as! UILabel
        activityLabel.text = "Training"
        self.view.backgroundColor = .green
        self.navigationController?.navigationBar.tintColor = .black
        self.view.viewWithTag(2)?.isHidden = false
        TimeLabel.textColor = .black
        activateProximitySensor(isOn: true)
        Vibration.error.vibrate()
    }
    
    func timeStoped(){
        activateProximitySensor(isOn: false)
        let activityLabel = ActivityView.viewWithTag(1) as! UILabel
        activityLabel.text = "Break"
        self.view.backgroundColor = .yellow
        self.navigationController?.navigationBar.tintColor = .black
        self.view.viewWithTag(2)?.isHidden = false
        TimeLabel.textColor = .black
        Vibration.error.vibrate()
        activateProximitySensor(isOn: true)
    }
    
}
