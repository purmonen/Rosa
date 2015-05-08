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
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateSensors", userInfo: nil, repeats: true)
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
            var sensors = [Sensor]()
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
//                                sensors.append(Sensor(name: ip, temperature: Double(Int(rand()) % 30), isConnected: true, image: UIImage(data: imageData)!,timestamp: NSDate()))
                                sensors.append(Sensor(name: ip, temperature: temperature, image: UIImage(data: imageData)!,timestamp: date))
                        }
                    }
                }
                self.sensors = sensors
                self.delegates.map { $0.sensorManagerDidSync() }
                println("Delegates count: \(self.delegates.count)")
            }
        }
    }
    
}