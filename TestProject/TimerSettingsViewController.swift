//
//  TimerSettingsViewController.swift
//  TestProject
//
//  Created by admin on 25.01.2023.
//

import UIKit

class TimerSettingsViewController: UIViewController{
    
    @IBOutlet weak var RoundsLabel: UILabel!
    @IBOutlet weak var TimePerRoundLabel: UILabel!
    
    @IBAction func RoundsStepper(_ sender: UIStepper) {
        rounds = sender.value
        print("Rounds: \(rounds) Time per round: \(timePerRound) Break \(breakTime)")
        updateLabels()
        Vibration.light.vibrate()
        if rounds > 1 {
            BreakSwitch.isEnabled = true
            configureSwitch()
        } else {
            BreakSwitch.setOn(false, animated: true)
            BreakSwitch.isEnabled = false
            configureSwitch()
            IsBreak(BreakSwitch)
        }
    }
    @IBAction func TimeStepper(_ sender: UIStepper) {
        timePerRound = sender.value/2
        print("Rounds: \(rounds) Time per round: \(timePerRound) Break \(breakTime)")
        updateLabels()
        Vibration.light.vibrate()
    }
    
    @IBOutlet weak var BreakView: UIView!
    
    @IBOutlet weak var BreakSwitch: UISwitch!
    
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
    
    
    @IBOutlet weak var TimeForBreakText: UILabel!
    @IBOutlet weak var BreakTime: UILabel!
    @IBOutlet weak var BreakTimeStepperOutlet: UIStepper!
    
    @IBAction func BreakTimeStepper(_ sender: UIStepper) {
        breakTime = sender.value/2
        print("Rounds: \(rounds) Time per round: \(timePerRound) Break \(breakTime)")
        updateLabels()
        Vibration.light.vibrate()
    }
    
    var rounds: Double = 1
    var timePerRound = 0.5
    var withBreak = false
    var breakTime: Double = 0.5

    override func viewDidLoad() {
        print("Rounds: \(rounds) Time per round: \(timePerRound) Break \(breakTime)")
        super.viewDidLoad()
        setupMenu()
        updateLabels()
        BreakSwitch.setOn(false, animated: true)
        BreakSwitch.isEnabled = false
        configureSwitch()
        TimeForBreakText.isEnabled = false
        BreakTime.isEnabled = false
        BreakTimeStepperOutlet.isEnabled = false
    }
    
    func updateLabels(){
        RoundsLabel.text = String(Int(rounds))
        TimePerRoundLabel.text = String(timePerRound)
        BreakTime.text = String(breakTime)
    }
    
    func configureSwitch(){
        if BreakSwitch.isEnabled {
            BreakSwitch.backgroundColor = .red
        } else {
            BreakSwitch.backgroundColor = .gray
        }
        BreakSwitch.clipsToBounds = true
        BreakSwitch.layer.cornerRadius = BreakSwitch.frame.height/2
    }
    
    func setupMenu(){
        BreakView.clipsToBounds = true
        var rect = BreakView.viewWithTag(1)!
        rect.clipsToBounds = true
        rect.layer.cornerRadius = rect.frame.height/2.3
        BreakView.layer.cornerRadius = rect.frame.height/2.3+1
        rect = self.view.viewWithTag(1)!
        rect.clipsToBounds = true
        rect.layer.cornerRadius = 20
        BreakView.viewWithTag(2)?.clipsToBounds = true
        BreakView.viewWithTag(2)?.layer.cornerRadius = 20
    }
    
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
extension TimerSettingsViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}
