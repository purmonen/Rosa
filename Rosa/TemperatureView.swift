//
//  TemperatureView.swift
//  Rosa
//
//  Created by Sami Purmonen on 07/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit

class TemperatureView: UIView {

    //1 - the properties for the gradient
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    
    
//    let temperatures = [10,15,12,24,21,19,27,21,15,14,13]
    let temperatures = (0..<15).map { _ in 10 + Int(rand()) % 20 }
    
    override func drawRect(rect: CGRect) {
        
        //2 - get the current context
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextSetLineWidth(context, 2.0)
        CGContextMoveToPoint(context, 0, 0)
        
        for (i, temperature) in enumerate(temperatures) {
            CGContextAddLineToPoint(context, CGFloat(i*Int(bounds.width)/(temperatures.count-1)), CGFloat(temperature)*4)
        }

        CGContextStrokePath(context)
    }
    

}
