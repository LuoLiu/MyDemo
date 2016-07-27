//
//  ViewController.swift
//  Counter_swift
//
//  Created by LuoLiu on 15/12/28.
//  Copyright © 2015年 fenrir_cd08. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timeLabel: UILabel?
    var timeButtons: [UIButton]?
    var startStopButton: UIButton?
    var clearButton: UIButton?
    let timeBtnInfos = [("1Mins", 60), ("3Mins", 180), ("5Mins", 300), ("s", 1)]
    var timer: NSTimer?
    
    var remainingSeconds: Int = 0 {
        willSet(newSeconds) {
            let mins = newSeconds/60
            let seconds = newSeconds%60
            self.timeLabel!.text = String(format: "%02d:%02d", mins, seconds)
        }
    }
    
    var isCounting: Bool = false {
        willSet(newValue) {
            if newValue {
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
            }
            setSettingButtonsEnabled(!newValue)
        }
    }
    
    typealias Task = (cancel: Bool) -> Void
    
    func delay(time: NSTimeInterval, task:()->()) -> Task? {
        func dispatch_later(block:()->()) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time*Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
        }
        
        var closure: dispatch_block_t? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    dispatch_async(dispatch_get_main_queue(), internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        result = delayedClosure
        
        dispatch_later { () -> () in
            if let delayedClosure = result {
                delayedClosure(cancel: false)
            }
        }
        return result
    }
    
    func cancel(task:Task?) {
        task?(cancel: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delay(2.0, task: { print("Do sometiong 2 seconds later") })
        let task = delay(5.0, task: { print("Do sometiong 5 seconds later") })
        delay(1.0, task: { self.cancel(task) })
        
        
        //setupTimeLabel
        timeLabel = UILabel()
        timeLabel!.textColor = UIColor.whiteColor()
        timeLabel!.font = UIFont.systemFontOfSize(80)
        timeLabel!.backgroundColor = UIColor.blackColor()
        timeLabel!.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(timeLabel!)
        
        //setuptimeButtons
        var buttons: [UIButton] = []
        for (index, (title, _)) in timeBtnInfos.enumerate() {
            let button: UIButton = UIButton()
            button.tag = index
            button.setTitle("\(title)", forState: UIControlState.Normal)
            
            button.backgroundColor = UIColor.orangeColor()
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            
            button.addTarget(self, action: "timeButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            
            buttons.append(button)
            self.view.addSubview(button)
        }
        timeButtons = buttons
        
        //setupActionButtons
        startStopButton = UIButton()
        startStopButton!.backgroundColor = UIColor.redColor()
        startStopButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        startStopButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        startStopButton!.setTitle("Start/Stop", forState: UIControlState.Normal)
        startStopButton!.addTarget(self, action: "startStopButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(startStopButton!)
        
        clearButton = UIButton()
        clearButton!.backgroundColor = UIColor.redColor()
        clearButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        clearButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        clearButton!.setTitle("Reset", forState: UIControlState.Normal)
        clearButton!.addTarget(self, action: "clearButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(clearButton!)
    }
    
    func timeButtonTapped(sender: UIButton) {
        let (_, seconds) = timeBtnInfos[sender.tag]
        remainingSeconds += seconds
    }
    
    func startStopButtonTapped(sender: UIButton) {
        isCounting = !isCounting
    }
    
    func clearButtonTapped(sender: UIButton) {
        remainingSeconds = 0
    }
    
    func updateTimer(timer: NSTimer) {
        remainingSeconds -= 1
    }
    
    func setSettingButtonsEnabled(enabled: Bool) {
        for button in self.timeButtons! {
            button.enabled = enabled
            button.alpha = enabled ? 1.0 : 0.3
        }
        clearButton!.enabled = enabled
        clearButton!.alpha = enabled ? 1.0 : 0.3
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        timeLabel!.frame = CGRectMake(10, 140, self.view.bounds.size.width-20, 120)
        
        let gap = ( self.view.bounds.size.width - 10*2 - (CGFloat(timeButtons!.count) * 64) ) / CGFloat(timeButtons!.count - 1)
        for (index, button) in timeButtons!.enumerate() {
            let buttonLeft = 10 + (64 + gap) * CGFloat(index)
            button.frame = CGRectMake(buttonLeft, self.view.bounds.size.height-180, 64, 44)
        }
        
        startStopButton!.frame = CGRectMake(10, self.view.bounds.size.height-120, self.view.bounds.size.width-20-100, 44)
        clearButton!.frame = CGRectMake(10+self.view.bounds.size.width-20-100+20, self.view.bounds.size.height-120, 80, 44)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

