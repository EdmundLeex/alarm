//
//  Alarm.swift
//  alarm
//
//  Created by edmund on 9/20/16.
//  Copyright © 2016 edmund. All rights reserved.
//

import Foundation

class Alarm {
    var name: String?
    var alarmTime: NSDate?
//    var params: [String: AnyObject]?
    
    init(alarmName: String, time: NSDate) {
        self.name = alarmName
        self.alarmTime = time
    }
    
    func toDict() -> [String: AnyObject] {
        return [
            "name": name!,
            "alarm_time": alarmTime!
        ]
    }
}