//
//  TimerSettingsViewController.swift
//  TestProject
//
//  Created by admin on 25.01.2023.
//

import UIKit

class TimerSettingsViewController: UIViewController{
    
    //MARK: - Title view
    
    @IBOutlet weak var TitleView: UIView!
    
    //MARK: - Info view
    
    @IBOutlet weak var RoundsLabel: UILabel!
    @IBOutlet weak var TimePerRoundLabel: UILabel!
    
    @IBAction func RoundsStepper(_ sender: UIStepper) {
        rounds = sender.value
        updateLabels()
        Vibration.light.vibrate()
        if rounds > 1 {
            BreakSwitch.isEnabled = true
            updateBreakSwitch()
        } else {
            BreakSwitch.setOn(false, animated: true)
            BreakSwitch.isEnabled = false
            updateBreakSwitch()
            IsBreak(BreakSwitch)
        }
    }
    
    @IBAction func TimeStepper(_ sender: UIStepper) {
        timePerRound = sender.value/2
        updateLabels()
        Vibration.light.vibrate()
    }
    
    //MARK: - Break view
    
    @IBOutlet weak var BreakView: UIView!
    @IBOutlet weak var BreakSwitch: UISwitch!
    @IBOutlet weak var TimeForBreakText: UILabel!
    @IBOutlet weak var BreakTime: UILabel!
    @IBOutlet weak var BreakTimeStepperOutlet: UIStepper!
    
    @IBAction func IsBreak(_ sender: UISwitch) {
        if sender.isOn{
            TimeForBreakText.isEnabled = true
            BreakTime.isEnabled = true
            BreakTimeStepperOutlet.isEnabled = true
            withBreak = true
        } else {
            TimeForBreakText.isEnabled = false
            BreakTime.isEnabled = false
            BreakTimeStepperOutlet.isEnabled = false
            withBreak = false
        }
    }
    
    @IBAction func BreakTimeStepper(_ sender: UIStepper) {
        breakTime = sender.value/2
        updateLabels()
        Vibration.light.vibrate()
    }
    
    //MARK: - Start Button View
    
    
    @IBOutlet weak var StartButtonView: UIView!
    
    
    //MARK: - Timer variables
    
    var rounds: Double = 1
    var timePerRound = 0.5
    var withBreak = false
    var breakTime: Double = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
        setupBreakMenu()
        setupStartButtonView()
        updateLabels()
        configureBreakSwitch()
    }
    
    func updateLabels(){
        RoundsLabel.text = String(Int(rounds))
        TimePerRoundLabel.text = String(timePerRound)
        BreakTime.text = String(breakTime)
    }
    
    func configureBreakSwitch(){
        BreakSwitch.isEnabled = false
        BreakSwitch.backgroundColor = .gray
        BreakSwitch.clipsToBounds = true
        BreakSwitch.layer.cornerRadius = BreakSwitch.frame.height/2
    }
    
    func updateBreakSwitch(){
        if BreakSwitch.isEnabled {
            BreakSwitch.backgroundColor = .red
        } else {
            BreakSwitch.backgroundColor = .gray
        }
    }
    
    func setupTitleView(){
        TitleView.clipsToBounds = true
        TitleView.layer.cornerRadius = 20
        TitleView.backgroundColor = UIColor(named: "MainColor")
    }
    
    func setupStartButtonView(){
        StartButtonView.backgroundColor = .black
        StartButtonView.clipsToBounds = true
        StartButtonView.layer.cornerRadius = 20
    }
    
    func setupBreakMenu(){
        BreakView.backgroundColor = UIColor(named: "MainColor")
        TimeForBreakText.isEnabled = false
        BreakTime.isEnabled = false
        BreakTimeStepperOutlet.isEnabled = false
        BreakView.clipsToBounds = true
        var BreakSwitchView = BreakView.viewWithTag(1)!
        BreakSwitchView.clipsToBounds = true
        BreakSwitchView.layer.cornerRadius = BreakSwitchView.frame.height/2.3
        BreakView.layer.cornerRadius = BreakSwitchView.frame.height/2.3+1
    }
    
    //MARK: - Segue prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartTimer" {
            Vibration.heavy.vibrate()
            print("Timer Started")
            let controller = segue.destination as! TimerViewController
            controller.timePerRound = Int(timePerRound*60)
            controller.rounds = Int(rounds)
            controller.TimeForBreak = Int(breakTime*60)
            controller.withBreak = withBreak
        }
    }

}

