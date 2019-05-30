//
//  AnimationPath.swift
//  Alison
//
//  Created by Benjamin Pisano on 26/01/2019.
//  Copyright © 2019 Snopia. All rights reserved.
//

import UIKit

internal class AnimationPath: NSObject {
    
    internal enum Shape {
        
        case circle
        case oval
        
    }
    
    static func rose(rotation: CGFloat, scale: CGFloat, petalNumber: CGFloat = 2, spacing: CGFloat = 16, clockwise: Bool = true) -> UIBezierPath {
        let path = UIBezierPath()
        let through = clockwise ? 2 * CGFloat.pi : -2 * CGFloat.pi
        let by = clockwise ? 2 * CGFloat.pi / 1000 : -2 * CGFloat.pi / 1000
        
        for t in stride(from: 0, through: through, by: by) {
            let x = petalNumber * cos(t) + spacing * cos(petalNumber * t)
            let y = petalNumber * sin(t) - spacing * sin(petalNumber * t)
            let point = CGPoint(x: x * scale, y: y * scale)
            let rotatedX = cos(rotation) * point.x - sin(rotation) * point.y;
            let rotatedY = sin(rotation) * point.x + cos(rotation) * point.y;
            let rotatedPoint = CGPoint(x: rotatedX, y: rotatedY)
            
            if t == 0 {
                path.move(to: rotatedPoint)
            } else {
                path.addLine(to: rotatedPoint)
            }
        }
        
        return path
    }
    
    static func circle(radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint.zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        return path
    }
    
    static func rose(rotation: CGFloat, radius: CGFloat, petalNumber: CGFloat = 2, spacing: CGFloat = 16, clockwise: Bool = true) -> UIBezierPath {
        let path = UIBezierPath()
        let through = clockwise ? 2 * CGFloat.pi : -2 * CGFloat.pi
        let by = clockwise ? 2 * CGFloat.pi / 1000 : -2 * CGFloat.pi / 1000
        let scale = roseScale(scale: 1, rotation: rotation, radius: radius, petalNumber: petalNumber, spacing: spacing, clockwise: clockwise)
        
        for t in stride(from: 0, through: through, by: by) {
            let x = petalNumber * cos(t) + spacing * cos(petalNumber * t)
            let y = petalNumber * sin(t) - spacing * sin(petalNumber * t)
            let point = CGPoint(x: x * scale, y: y * scale)
            let rotatedX = cos(rotation) * point.x - sin(rotation) * point.y;
            let rotatedY = sin(rotation) * point.x + cos(rotation) * point.y;
            let rotatedPoint = CGPoint(x: rotatedX, y: rotatedY)
            
            if t == 0 {
                path.move(to: rotatedPoint)
            } else {
                path.addLine(to: rotatedPoint)
            }
        }
        
        return path
    }
    
    static func roseScale(scale: CGFloat, rotation: CGFloat, radius: CGFloat, petalNumber: CGFloat, spacing: CGFloat, clockwise: Bool) -> CGFloat {
        let through = clockwise ? 2 * CGFloat.pi : -2 * CGFloat.pi
        let by = clockwise ? 2 * CGFloat.pi / 1000 : -2 * CGFloat.pi / 1000
        var maxRadius: CGFloat = 0
        
        for t in stride(from: 0, through: through, by: by) {
            let x = petalNumber * cos(t) + spacing * cos(petalNumber * t)
            let y = petalNumber * sin(t) - spacing * sin(petalNumber * t)
            let point = CGPoint(x: x * scale, y: y * scale)
            let rotatedX = cos(rotation) * point.x - sin(rotation) * point.y;
            let rotatedY = sin(rotation) * point.x + cos(rotation) * point.y;
            let rotatedPoint = CGPoint(x: rotatedX, y: rotatedY)
            let newRadius = sqrt(pow(rotatedPoint.x, 2) + pow(rotatedPoint.y, 2))
            
            if newRadius > maxRadius {
                maxRadius = newRadius
            }
        }
        
        if maxRadius > radius {
            return scale - 0.5
        }
        
        return roseScale(scale: scale + 0.5, rotation: rotation, radius: radius, petalNumber: petalNumber, spacing: spacing, clockwise: clockwise)
    }

}
