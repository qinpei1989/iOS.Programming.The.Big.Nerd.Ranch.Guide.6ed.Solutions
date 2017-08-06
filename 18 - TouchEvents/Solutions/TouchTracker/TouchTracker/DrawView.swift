//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class DrawView: UIView {
    
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    var currentCircle = Circle()
    var finishedCircles = [Circle]()

    @IBInspectable var finishedCircleColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var currentCircleColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
 
    func stroke(_ line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    func stroke(_ circle: Circle) {
        let path = UIBezierPath(ovalIn: circle.rect)
        path.lineWidth = lineThickness
        path.stroke()
    }

    override func draw(_ rect: CGRect) {
        for line in finishedLines {
            line.lineColor.setStroke()
            stroke(line)
        }
        
        for (_, line) in currentLines {
            line.lineColor.setStroke()
            stroke(line)
        }
        
        finishedCircleColor.setStroke()
        for circle in finishedCircles {
            stroke(circle)
        }
        
        currentCircleColor.setStroke()
        stroke(currentCircle)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Let's put in a log statement to see the order of events
        print(#function)
        
        if touches.count == 2 {
            let touchArray = Array(touches)
            let touchPoint1 = touchArray[0].location(in: self)
            let touchPoint2 = touchArray[1].location(in: self)
            currentCircle = Circle(point1: touchPoint1, point2: touchPoint2)
        } else {
            for touch in touches {
                let location = touch.location(in: self)
                
                let newLine = Line(begin: location, end: location)
                
                let key = NSValue(nonretainedObject: touch)
                currentLines[key] = newLine
            }
        }

        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Let's put in a print statement to see the order of events
        print(#function)
        
        if touches.count == 2 {
            let touchArray = Array(touches)
            let touchPoint1 = touchArray[0].location(in: self)
            let touchPoint2 = touchArray[1].location(in: self)
            currentCircle = Circle(point1: touchPoint1, point2: touchPoint2)
        } else {
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                currentLines[key]?.end = touch.location(in: self)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Let's put in a log statement to see the order of events
        print(#function)
        
        if touches.count == 2 {
            let touchArray = Array(touches)
            let touchPoint1 = touchArray[0].location(in: self)
            let touchPoint2 = touchArray[1].location(in: self)
            currentCircle = Circle(point1: touchPoint1, point2: touchPoint2)
            finishedCircles.append(currentCircle)
            currentCircle = Circle()
        } else {
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                if var line = currentLines[key] {
                    line.end = touch.location(in: self)
                    
                    finishedLines.append(line)
                    currentLines.removeValue(forKey: key)
                }
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Let's put in a log statement to see the order of events
        print(#function)
        
        currentLines.removeAll()
        currentCircle = Circle()
        
        setNeedsDisplay()
    }
    
}
