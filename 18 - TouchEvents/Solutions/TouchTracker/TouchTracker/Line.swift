//
//  Copyright © 2015 Big Nerd Ranch
//

import Foundation
import CoreGraphics
import UIKit

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero
    
    /*
     * Silver Challenge: Colors
     *
     * 1. Define an array of UIColor to select
     * 2. Calculate the angle in radians between the end point and begin point
     * 3. The angle is in range [-pi, +pi], so normalize it to get the correct array index
     */
    var lineColor: UIColor {
        
        let colors = [UIColor.green, UIColor.red, UIColor.yellow,
                      UIColor.black, UIColor.blue, UIColor.brown,
                      UIColor.orange, UIColor.gray, UIColor.purple,
                      UIColor.cyan, UIColor.magenta, UIColor.lightGray]
        
        let dy = end.y - begin.y
        let dx = end.x - begin.x
        let angleInRadians = (Double)(atan2(dy, dx))
        
        let ratio = (angleInRadians + Double.pi) / (2 * Double.pi)
        let colorIndex = (Int)((Double)(colors.count - 1) * ratio)
        
        return colors[colorIndex]
    }
}
