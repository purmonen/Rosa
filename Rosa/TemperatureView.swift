import UIKit

class TemperatureView: UIView {
//    let temperatures = (0..<30).map { _ in 10 + Int(rand()) % 20 }
    var temperatures = [Double]()
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if let sensor = selectedSensor{
            SensorManager.getTemperaturesForIp(sensor.name)
        }
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        
        // Draw axis
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, 0, bounds.height)
        CGContextAddLineToPoint(context, bounds.width, bounds.height)
        CGContextStrokePath(context)
        
        
        for i in 1..<5{
            CGContextMoveToPoint(context, 0, 0)
            CGContextAddLineToPoint(context, 0, bounds.height*CGFloat(i)/5.0)
            CGContextAddLineToPoint(context, bounds.width/50, bounds.height*CGFloat(i)/5.0)
            CGContextStrokePath(context)
            
            
        }
        
        // Draw temperatures
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        for (i, temperature) in enumerate(temperatures) {
            if i == 0 {
                CGContextMoveToPoint(context, 0, (100 - CGFloat(temperature))/100*CGFloat(bounds.height))
            } else {
                CGContextAddLineToPoint(context, CGFloat(i*Int(bounds.width)/(temperatures.count-1)), (100 - CGFloat(temperature))/100*CGFloat(bounds.height))
            }
        }
        CGContextStrokePath(context)
    }
}
