//
//  SensorTableViewController.swift
//  Rosa
//
//  Created by Sami Purmonen on 07/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit

var selectedSensor: Sensor?



class SensorTableViewController: UITableViewController, SensorManagerDelegate {
    
    var sensors = [Sensor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        SensorManager.addDelegate(self)
    }
    
    func sensorManagerDidSync() {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.sensors = SensorManager.sensors
            self.tableView.reloadData()
        }
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
        
        
        cell.temperatureLabel.text = sensor.isConnected ? String(format: "%.1f °C", arguments: [sensor.temperature]) : ""
        
        cell.descriptionLabel.text = sensor.description
        
        cell.cameraImageView.image = sensor.image
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = tableView.indexPathForSelectedRow() {
            selectedSensor = sensors[indexPath.row]
        }
    }
    
}
