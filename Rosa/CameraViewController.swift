//
//  CameraViewController.swift
//  Rosa
//
//  Created by Paul Griffin on 08/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, SensorManagerDelegate {
    
    @IBOutlet weak var cameraImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sensorManagerDidSync()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        SensorManager.addDelegate(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SensorManager.removeDelegate(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sensorManagerDidSync() {
        if let image = SensorManager.sensors.filter({ $0.name == selectedSensor?.name ?? "" }).first?.image {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.cameraImage.image = image
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
