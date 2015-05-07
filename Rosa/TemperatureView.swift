//
//  TemperatureView.swift
//  Rosa
//
//  Created by Sami Purmonen on 07/05/15.
//  Copyright (c) 2015 Sami Purmonen. All rights reserved.
//

import UIKit

class TemperatureView: UIView {
    let temperatures = (0..<15).map { _ in 10 + Int(rand()) % 20 }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        
        // Draw axis
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, 0, bounds.height)
        CGContextAddLineToPoint(context, bounds.width, bounds.height)
        CGContextStrokePath(context)
        
        
        // Draw temperatures
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextMoveToPoint(context, 0, CGFloat(temperatures[0]))
        for (i, temperature) in enumerate(temperatures) {
            if i == 0 {
                continue
            }
            CGContextAddLineToPoint(context, CGFloat(i*Int(bounds.width)/(temperatures.count-1)), CGFloat(temperature)*4)
        }

        CGContextStrokePath(context)
    }
    

}
