//
//  AlarmsTableViewController.swift
//  alarm
//
//  Created by edmund on 9/27/16.
//  Copyright © 2016 edmund. All rights reserved.
//

import UIKit

class AlarmsTableViewController: UITableViewController {
    
    let dateFormatter = NSDateFormatter()
    var alarms: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Api.fetchAlarms(completion: setAndDisplayAlarms)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alarms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlarmTableViewCell", forIndexPath: indexPath) as! AlarmTableViewCell
        print(alarms)
        let alarm = alarms[indexPath.row] as! Alarm
        cell.alarmNameLabel.text = alarm.name!
        cell.alarmTimeLabel.text = dateFormatter.stringFromDate(alarm.alarmTime!)

        return cell
    }
    
    private
    
    func setAndDisplayAlarms(alarmsPayload: NSArray) {
        createAlarms(alarmsPayload)
        self.tableView.reloadData()
    }
    
    func createAlarms(alarmsPayload: NSArray) {
        for alarmPayload in alarmsPayload {
            let name = alarmPayload["name"] as? String ?? "Alarm"
            let timeStr = alarmPayload["alarm_time"] as! String
            dateFormatter.dateFormat = "HH:mm z"
            
            if let alarmTime = dateFormatter.dateFromString(timeStr) {
                self.alarms.addObject(Alarm(alarmName: name, time: alarmTime))
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
