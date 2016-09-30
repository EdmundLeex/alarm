//
//  ViewController.swift
//  alarm
//
//  Created by edmund on 8/23/16.
//  Copyright © 2016 edmund. All rights reserved.
//

import UIKit
import Alamofire

class AlarmFormViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTF: UITextField!
    
    @IBOutlet weak var display: UILabel!
    
    @IBAction func timePickerAction(sender: AnyObject) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let strTime = timeFormatter.stringFromDate(timePicker.date)
        display.text = strTime
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func submitBtn(sender: AnyObject) {
        print(timePicker.date)
        
        let alarm = Alarm(alarmName: alarmNameTF.text!, time: timePicker.date)
        
        Api.createAlarm(alarm)
        
        let params : [String : AnyObject] = [
            "alarm": [
                "alarm_time": timePicker.date,
                "name": alarmNameTF.text! as NSString
            ] as Dictionary
        ]

        Alamofire.request(
            .POST,
            "https://332a27d3.ngrok.io/alarms",
            parameters: params
        ).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            self.navigationController?.popViewControllerAnimated(true)
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}

