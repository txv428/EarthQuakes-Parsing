//
//  Date+Extension.swift
//  EarthQuakesParsing
//
//  Created by tejasree vangapalli on 6/1/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

extension Date {
    init(longIntTimeIntervalSince1970: Double) {
        self.init(timeIntervalSince1970: longIntTimeIntervalSince1970/1000)
    }
    
    // Convert date to string format
    func dateToString() -> String {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd, YYYY"
        let dateString = dayTimePeriodFormatter.string(from: self)
        return dateString
    }
    
    // Convert time to string format
    func timeToString() -> String {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "hh:mm a"
        let dateString = dayTimePeriodFormatter.string(from: self)
        return dateString
    }
    
    // to get the past month date from given time
    func dateString30DaysFromNow() -> String {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "YYYY-MM-dd"
        let pastMonth = TimeInterval(-30*24*60*60)
        let dateString = dayTimePeriodFormatter.string(from: self.addingTimeInterval(pastMonth))
        return dateString
    }
}

