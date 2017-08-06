//
//  Circle.swift
//  TouchTracker
//
//  Created by Pei Qin on 08/06/2017.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

/*
 * Gold Challenge: Circles
 */

import Foundation
import CoreGraphics

struct Circle {
    var rect: CGRect
    
    init() {
        self.rect = CGRect.zero
    }
    
    init(rect: CGRect) {
        self.rect = rect
    }
    
    init(point1: CGPoint, point2: CGPoint) {
        let width = abs(point2.x - point1.x)
        let height = abs(point2.y - point1.y)
        let radius = max(width, height) / 2
        let center = CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
        self.rect = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    }
}
