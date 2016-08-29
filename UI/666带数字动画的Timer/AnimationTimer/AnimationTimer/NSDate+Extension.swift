//
//  NSDate+Extension.swift
//  TimerDemo
//
//  Created by LuoLiu on 16/8/26.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import Foundation

extension NSDate {
    
    private static func comp() -> NSDateComponents {
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute, .Second], fromDate: NSDate())
        return comp
    }
    
    static func hourOnesDigit() -> Int {
        return NSDate.comp().hour%10
    }
    
    static func hourTensDigit() -> Int {
        return NSDate.comp().hour/10
    }
    
    static func minuteOnesDigit() -> Int {
        return NSDate.comp().minute%10
    }
    
    static func minuteTensDigit() -> Int {
        return NSDate.comp().minute/10
    }
    
    static func secondOnesDigit() -> Int {
        return NSDate.comp().second%10
    }
    
    static func secondTensDigit() -> Int {
        return NSDate.comp().second/10
    }
}
