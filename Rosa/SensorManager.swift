//
//  SensorManager.swift
//  Rosa
//
//  Created by Sami Purmonen on 08/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit

protocol SensorManagerDelegate: class {
    func sensorManagerDidSync()
}

let SensorManager = _SensorManager()
class _SensorManager: NSObject {
    var timer: NSTimer?
    
    var sensors = [Sensor]()
    
    override init() {
        super.init()
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "updateSensors", userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    var delegates = [SensorManagerDelegate]()
    
    func addDelegate(delegate: SensorManagerDelegate) {
        if delegates.filter({ $0 === delegate }).isEmpty {
            delegates.append(delegate)
        }
    }
    
    func removeDelegate(delegate: SensorManagerDelegate) {
        delegates = delegates.filter { $0 !== delegate }
    }
    
    func updateSensors() {
        NSOperationQueue().addOperationWithBlock {
                self.sensors = DatabaseConnector().getAllSensors()
                self.delegates.map { $0.sensorManagerDidSync() }
        }
    }
    
    func getTemperaturesForIp(name: String) -> [Double] {
        return DatabaseConnector().getAllTemperaturesForIp(name)
    }
}