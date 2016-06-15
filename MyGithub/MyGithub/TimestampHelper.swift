//
//  TimestampHelper.swift
//  MyGithub
//
//  Created by David Nadri on 6/13/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation

extension NSDate {
    
    func yearsFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
    
    func monthsFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
    }
    
    func weeksFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    
    func daysFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
    }
    
    func hoursFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: []).hour
    }
    
    func minutesFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
    }
    
    func secondsFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
    }
    
    func offsetFrom(date: NSDate) -> String {
        if yearsFrom(date)   > 0 { return "Updated \(yearsFrom(date)) years ago"   }
        if monthsFrom(date)  > 0 { return "Updated \(monthsFrom(date)) months ago"  }
        if weeksFrom(date)   > 0 { return "Updated \(weeksFrom(date)) weeks ago"   }
        if daysFrom(date)    > 0 { return "Updated \(daysFrom(date)) days ago"    }
        if hoursFrom(date)   > 0 { return "Updated \(hoursFrom(date)) hours ago"   }
        if minutesFrom(date) > 0 { return "Updated \(minutesFrom(date)) minutes ago" }
        if secondsFrom(date) > 0 { return "Updated \(secondsFrom(date)) seconds ago" }
        return "now"
    }
    
}
