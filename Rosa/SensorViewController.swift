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
    
    
    var _sensor: Sensor?
    var sensor: Sensor? {
        set {
            _sensor = newValue

            if let sensor = sensor{
                if cameraImageView != nil {
                    cameraImageView.image = UIImage(data: sensor.imageData)
                }
            }
        }
        get {
            return _sensor
        }
    }
    
    

    @IBOutlet weak var cameraImageView: UIImageView!


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        if let sensor = sensor{
            cameraImageView.image = UIImage(data: sensor.imageData)
        }
    }
}
