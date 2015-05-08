//
//  TemperatureViewController.swift
//  Rosa
//
//  Created by Paul Griffin on 08/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, SensorManagerDelegate {

    func sensorManagerDidSync() {
        NSOperationQueue().addOperationWithBlock {
            let temperatures = databaseConnector().getAllTemperaturesForIp(selectedSensor!.name)
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.temperatureView.temperatures = temperatures
                self.temperatureView.setNeedsDisplay()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        SensorManager.addDelegate(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SensorManager.removeDelegate(self)
    }
    
    @IBOutlet weak var temperatureView: TemperatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sensorManagerDidSync()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
