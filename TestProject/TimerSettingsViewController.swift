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
        updateLabels()
    }
    @IBAction func TimeStepper(_ sender: UIStepper) {
        timePerRound = sender.value/2
        updateLabels()
    }
    
    @IBOutlet weak var BreakView: UIView!
    
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
        updateLabels()
    }
    
    var rounds: Double = 3
    var timePerRound = 2.5
    var withBreak = false
    var breakTime: Double = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        updateLabels()
        TimeForBreakText.isEnabled = false
        BreakTime.isEnabled = false
        BreakTimeStepperOutlet.isEnabled = false
    }
    
    func updateLabels(){
        RoundsLabel.text = String(Int(rounds))
        TimePerRoundLabel.text = String(timePerRound)
        BreakTime.text = String(breakTime)
    }
    
    func setupNavigationBar(){
        BreakView.clipsToBounds = true
        var rect = BreakView.viewWithTag(1)!
        rect.clipsToBounds = true
        rect.layer.cornerRadius = rect.frame.height/2.3
        BreakView.layer.cornerRadius = rect.frame.height/2.3
        rect = self.view.viewWithTag(1)!
        rect.clipsToBounds = true
        rect.layer.cornerRadius = 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartTimer" {
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
