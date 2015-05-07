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
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var containerViewControllers = [UIViewController]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewControllers = ["CameraViewController" ,"TemperatureViewController"].map { self.storyboard!.instantiateViewControllerWithIdentifier($0) as! UIViewController }
        changedView(segmentedControl)
    }
    
    
    @IBAction func changedView(sender: UISegmentedControl) {
        let controller = containerViewControllers[sender.selectedSegmentIndex]
        addChildViewController(controller)
        containerView.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
        controller.view.frame = containerView.bounds
        
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
