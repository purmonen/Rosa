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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewControllers = ["CameraViewController" ,"TemperatureViewController"].map { self.storyboard!.instantiateViewControllerWithIdentifier($0) as! UIViewController }
        changedView(segmentedControl)
    }
    override func viewDidAppear(animated: Bool) {
        if let sensor = selectedSensor{
            self.navigationItem.title = sensor.description
        }else{
            self.navigationItem.title = "Sensor"
        }
    }
    
    @IBAction func changedView(sender: UISegmentedControl) {
        let controller = containerViewControllers[sender.selectedSegmentIndex]
        addChildViewController(controller)
        containerView.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
        controller.view.frame = containerView.bounds
        controller.viewDidAppear(false)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
