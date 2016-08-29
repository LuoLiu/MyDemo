//
//  ViewController.swift
//  AnimationTimer
//
//  Created by LuoLiu on 16/8/29.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var digitViews: [AnimationDigitView]!
    
    var timer: NSTimer?
    // Timer Digits
    let rx_digits = [Variable(0), Variable(0), Variable(0), Variable(0), Variable(0), Variable(0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindRx()
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(changeTimerDigit), userInfo: nil, repeats: true)
    }
    
    private func bindRx() {
        for (index, digit) in rx_digits.enumerate() {
            self.bindDigit(digit, view: self.digitViews[index])
        }
    }
    
    private func bindDigit(digit: Variable<Int>, view: AnimationDigitView) {
        digit.asObservable()
            .observeOn(MainScheduler.instance)
            .skip(1)
            .distinctUntilChanged()
            .subscribeNext {
                view.digit = $0
            }
            .addDisposableTo(disposeBag)
    }
    
    @objc private func changeTimerDigit() {
        rx_digits[0].value = NSDate.hourTensDigit()
        rx_digits[1].value = NSDate.hourOnesDigit()
        rx_digits[2].value = NSDate.minuteTensDigit()
        rx_digits[3].value = NSDate.minuteOnesDigit()
        rx_digits[4].value = NSDate.secondTensDigit()
        rx_digits[5].value = NSDate.secondOnesDigit()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.timer?.invalidate()
        self.timer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}