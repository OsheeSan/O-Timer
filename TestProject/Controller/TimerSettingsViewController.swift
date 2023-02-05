//
//  TimerSettingsViewController.swift
//  TestProject
//
//  Created by admin on 25.01.2023.
//

import UIKit

class TimerSettingsViewController: UIViewController{
    //MARK: - CGColours
    
    let mainColor = CGColor(red: 1, green: 0.812, blue: 0, alpha: 1)
    let blackColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    //MARK: - Title view
    
    @IBOutlet weak var TitleView: UIView!
    
    //MARK: - Info view
    
    @IBOutlet weak var RoundsLabel: UILabel!
    @IBOutlet weak var TimePerRoundLabel: UILabel!
    
    @IBAction func RoundsStepper(_ sender: UIStepper) {
        timerManager.rounds = Int(sender.value)
        updateLabels()
        Vibration.light.vibrate()
        if timerManager.rounds > 1 {
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
        timerManager.timePerRound = Int(sender.value)
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
            TimeForBreakText.isHidden = false
            BreakTime.isHidden = false
            BreakTimeStepperOutlet.isHidden = false
            timerManager.withBreak = true
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, animations: {
                self.BreakView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.BreakView.backgroundColor = UIColor(named: "MainColor")
                self.BreakView.viewWithTag(1)?.backgroundColor = .black
                let BreakLabel = self.BreakView.viewWithTag(2) as? UILabel
                BreakLabel?.textColor = .white
            })
        } else {
            TimeForBreakText.isEnabled = false
            BreakTime.isEnabled = false
            BreakTimeStepperOutlet.isEnabled = false
            TimeForBreakText.isHidden = true
            BreakTime.isHidden = true
            BreakTimeStepperOutlet.isHidden = true
            timerManager.withBreak = false
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, animations: {
                self.BreakView.transform = CGAffineTransform(translationX: 0, y: 110)
                self.BreakView.backgroundColor = .black
                self.BreakView.viewWithTag(1)?.backgroundColor = UIColor(named: "MainColor")
                let BreakLabel = self.BreakView.viewWithTag(2) as? UILabel
                BreakLabel?.textColor = UIColor(named: "RevertLabel")
            })
        }
    }
    
    @IBAction func BreakTimeStepper(_ sender: UIStepper) {
        timerManager.breakTime = Int(sender.value)
        updateLabels()
        Vibration.light.vibrate()
    }
    
    //MARK: - Start Button View
    
    @IBOutlet weak var StartButtonView: UIView!
    
    
    //MARK: - Timer variables
    
    var timerManager = TimerManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
        setupBreakMenu()
        setupStartButtonView()
        updateLabels()
        configureBreakSwitch()
        
    }
    
    //MARK: - Helper methods
    
    func updateLabels(){
        RoundsLabel.text = String(timerManager.rounds)
        TimePerRoundLabel.text = timeToString(timerManager.timePerRound)
        BreakTime.text = timeToString(timerManager.breakTime)
    }
    
    func configureBreakSwitch(){
        BreakSwitch.isEnabled = false
        BreakSwitch.backgroundColor = .gray
        BreakSwitch.clipsToBounds = true
        BreakSwitch.layer.cornerRadius = BreakSwitch.frame.height/2
    }
    
    func updateBreakSwitch(){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, animations: {
            if self.BreakSwitch.isEnabled {
                self.BreakSwitch.backgroundColor = .black
            } else {
                self.BreakSwitch.backgroundColor = .gray
            }
        })
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
        StartButtonView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let startButton = StartButtonView.viewWithTag(2)
        startButton?.clipsToBounds = true
        startButton?.layer.cornerRadius = 25
        startButton?.layer.borderColor = mainColor
        startButton?.layer.borderWidth = 1
        let button = startButton?.viewWithTag(3) as? UIButton
        button?.clipsToBounds = true
        button?.layer.cornerRadius = 25
        button?.setBackgroundColor(UIColor(named: "MainColor")!, for: .highlighted)
    }
    
    func setupBreakMenu(){
        TimeForBreakText.isEnabled = false
        BreakTime.isEnabled = false
        BreakTimeStepperOutlet.isEnabled = false
        TimeForBreakText.isHidden = true
        BreakTime.isHidden = true
        BreakTimeStepperOutlet.isHidden = true
        BreakView.clipsToBounds = true
        let BreakSwitchView = BreakView.viewWithTag(1)!
        BreakSwitchView.clipsToBounds = true
        BreakSwitchView.layer.cornerRadius = 20
    }
    
    //MARK: - Segue prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartTimer" {
            Vibration.heavy.vibrate()
            print("Timer Started")
            let controller = segue.destination as! TimerViewController
            controller.timerManager = self.timerManager
        }
    }

}
extension UIButton {
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }
}
