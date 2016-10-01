//
//  Api.swift
//  alarm
//
//  Created by edmund on 9/20/16.
//  Copyright © 2016 edmund. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    static let api = Api()
    
    static let baseUrl = "https://3a2cae5a.ngrok.io"
    
    class func fetchAlarms(completion fn: (NSArray) -> Void) {
        Alamofire.request(
            .GET,
            "\(baseUrl)/alarms"
        ).responseJSON { response in
            let alarms = response.result.value
            fn(alarms as! NSArray)
        }
    }
    
    class func createAlarm(alarm: Alarm, closure: () -> Void) {
        let params = [
            "alarm": alarm.toDict()
        ]
        Alamofire.request(
            .POST,
            "\(baseUrl)/alarms",
            parameters: params
        ).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            closure()
        }
    }
    
    func editAlarm(alarm: Alarm) {
        
    }
    
    func deleteAlarm(alarm: Alarm) {
        
    }
    
    
}