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
    
    class func createAlarm(alarm: Alarm, fn: () -> Void) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userToken = defaults.valueForKey("oauthToken") as? String
        
        let params: [String: AnyObject] = [
            "alarm": alarm.toDict(),
            "oauth_token": userToken!
        ]

        Alamofire.request(
            .POST,
            "\(baseUrl)/alarms",
            parameters: params
        ).responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            fn()
        }
    }
    
    func editAlarm(alarm: Alarm) {
        
    }
    
    func deleteAlarm(alarm: Alarm) {
        
    }
    
    class func oauthUser(user: User, completion fn: () -> Void) {
        let params = [
            "user": user.toDict()
        ]
        Alamofire.request(
            .POST,
            "\(baseUrl)/api/auth/facebook",
            parameters: params
        ).responseJSON { response in
            let oauthToken = response.result.value!["oauth_token"]
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(oauthToken, forKey: "oauthToken")
            print(oauthToken)
            fn()
        }
    }
}