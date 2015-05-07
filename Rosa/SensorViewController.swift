//
//  SensorViewController.swift
//  Rosa
//
//  Created by Sami Purmonen on 07/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit

class SensorViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var sensor:Sensor?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sensor = sensor{
            nameLabel.text = "\(sensor.name) \(sensor.temperature)°C"
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
