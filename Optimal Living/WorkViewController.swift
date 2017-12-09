//
//  WorkViewController.swift
//  Optimal Living
//
//  Created by Chris Frerichs on 12/9/17.
//  Copyright © 2017 Chris Frerichs. All rights reserved.
//

import Foundation
import UIKit

class WorkViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
//    @IBAction func dismissLoader() {
//        if (self.presentingViewController != nil){
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
    
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    
    var workPeriodTime: Int = 0
    var restPeriodTime: Int = 0
    var workRestIterations: Int = 0
    var workout: Workout?
    
    
    let workPeriods = ["15", "20", "30", "45", "60", "90", "120", "180"]
    
    let restPeriods = ["5", "10", "15", "20", "30", "45", "60"]
    
    var seconds = 0
    var rest = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return self.workPeriods.count
        }
        else {
            return self.restPeriods.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return self.workPeriods[row]
        } else {
            return self.restPeriods[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            workPeriodTime = Int(workPeriods[row])!
            seconds = workPeriodTime
        } else {
            restPeriodTime = Int(restPeriods[row])!
            rest = restPeriodTime
        }
    }
    
    var timer = Timer()
    var timer2 = Timer()
    var timerOn = false
    // has the pause button been tapped
    var resumeTapped = false
    
    
    //MARK: - IBactions
    @IBAction func startButtonTapped(_ sender: Any) {
        if timerOn == false {
            runTimer()
        }
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(WorkViewController.updateTimer)), userInfo: nil, repeats: true)
        timerOn = true
    }
    func restTimer(){
        timer2 = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(WorkViewController.updaterestTimer)), userInfo: nil, repeats: true)
        timerOn = true
    }
    //work
    @objc func updateTimer() {
        rest = restPeriodTime
        if seconds < 1 {
            timer.invalidate()
            restTimer()
        } else {
            seconds -= 1
            workLabel.text = timeString(time:TimeInterval(seconds))
        }
    }
    //Rest
    @objc func updaterestTimer() {
        seconds = workPeriodTime
        if rest < 1 {
            timer2.invalidate()
            runTimer()
        } else {
            rest -= 1
            restLabel.text =
                timeString(time:TimeInterval(rest))
        }
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if self.resumeTapped == false {
            // stop timer without resetting the current value of seconds
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timer.invalidate()
        //        seconds = 20
        workLabel.text = timeString(time:TimeInterval(seconds))
        timerOn = false
    }
    
    func timeString(time:TimeInterval) -> String{
        let minutes = Int(time)/60 % 60
        let seconds = Int(time)%60
        return String(format:"%02i:%02i",minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



