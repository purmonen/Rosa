//
//  SensorTableViewController.swift
//  Rosa
//
//  Created by Sami Purmonen on 07/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit

var selectedSensor: Sensor?
var allSensors :[Sensor] = []

class SensorTableViewController: UITableViewController {
    
    var uniqueSensors :[Sensor] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSOperationQueue().addOperationWithBlock { () -> Void in
        if let  data = databaseConnector().getAllSensors() as? NSArray{
            for tmp in data{
                if let tmp = tmp as? [String:AnyObject]{
                    var dateformatter = NSDateFormatter()
                    dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    if let ip = tmp["ip"] as? String,
                        temperature = tmp["temp"] as? Double,
                        image = tmp["image"] as? String,
                        imageData = NSData(base64EncodedString: image, options: nil),
                        timestamp = tmp["timestamp"] as? String,
                        date = dateformatter.dateFromString(timestamp.stringByReplacingOccurrencesOfString(" UTC", withString: "", options: nil, range: nil)) {
                            
                            
                            //if !contains(uniqueSensors.map { $0.name }, ip) {
                                uniqueSensors.append(Sensor(name: ip, temperature: temperature, isConnected: true, image: UIImage(data: imageData)!,timestamp: NSDate()))
                            //}
                            allSensors.append(Sensor(name: ip, temperature: temperature, isConnected: true, image: UIImage(data: imageData)!,timestamp: NSDate()))
                    }
                }
            }
        }
        //}
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
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return uniqueSensors.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sensor = uniqueSensors[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("SensorTableViewCell", forIndexPath: indexPath) as! SensorTableViewCell
        
        cell.nameLabel?.text = uniqueSensors[indexPath.row].name
        cell.connectedLabel.textColor = sensor.isConnected ? UIColor.greenColor() : UIColor.redColor()
        let zebra = "-"
        cell.temperatureLabel.text = sensor.isConnected ? "\(sensor.temperature) °C" : ""
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
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
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let indexPath = tableView.indexPathForSelectedRow() {
            selectedSensor = uniqueSensors[indexPath.row]
        }
    }
    
}
