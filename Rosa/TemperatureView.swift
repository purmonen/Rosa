import UIKit

class TemperatureView: UIView {
//    let temperatures = (0..<30).map { _ in 10 + Int(rand()) % 20 }
    var temperatures = databaseConnector().getAllTemperaturesForIp(selectedSensor!.name)//allSensors.filter({$0.name == selectedSensor!.name}).map({$0.temperature})
    
    override func drawRect(rect: CGRect) {
        if let sensor = selectedSensor{
            databaseConnector().getAllTemperaturesForIp(sensor.name)
        }
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
        for (i, temperature) in enumerate(temperatures) {
            if i == 0 {
                CGContextMoveToPoint(context, 0, CGFloat(bounds.height) - CGFloat(temperature))
            } else {
                CGContextAddLineToPoint(context, CGFloat(i*Int(bounds.width)/(temperatures.count-1)), CGFloat(bounds.height) - CGFloat(temperature))
            }
        }
        CGContextStrokePath(context)
    }
}
