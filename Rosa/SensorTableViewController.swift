//
//  SensorTableViewController.swift
//  Rosa
//
//  Created by Sami Purmonen on 07/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit


class SensorTableViewController: UITableViewController {

    var sensors :[Sensor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //NSOperationQueue().addOperationWithBlock { () -> Void in
            if let  data = databaseConnector().getAllReadings() as? NSArray{
                for tmp in data{
                    if let tmp = tmp as? [String:AnyObject]{
                        let ip = tmp["ip"] as? String
                        let temperature = tmp["temp"] as? Double
                        let image = tmp["image"] as? String
                        if let ip = ip, temperature = temperature, imageData = NSData(base64EncodedString: image!, options: nil){
                            sensors.append(Sensor(name: ip, temperature: temperature, isConnected: true, imageData: imageData))
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
        return sensors.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sensor = sensors[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("SensorTableViewCell", forIndexPath: indexPath) as! SensorTableViewCell

        cell.nameLabel?.text = sensors[indexPath.row].name
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
        if let indexPath = tableView.indexPathForSelectedRow(),
            let dv = segue.destinationViewController as? SensorViewController {
            dv.sensor = sensors[indexPath.row]
        }
    }

}
