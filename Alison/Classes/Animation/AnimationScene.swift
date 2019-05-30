//
//  AnimationScene.swift
//  Alison
//
//  Created by Benjamin Pisano on 28/05/2019.
//  Copyright © 2019 Snopia. All rights reserved.
//

import SpriteKit

internal class AnimationScene: SKScene {
    
    internal var raySpeed: CGFloat = 4.2
    internal var rayRadius: CGFloat = 8
    internal var rayLenght: CGFloat = 5
    internal var rayCount: CGFloat = 3
    
    internal var rays: [AnimationRay] = []
    
    // MARK: - Init
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        configureUI()
        
        addCircleLight()
        addCircleRay()
        addOvalRays()
    }
    
    private func configureUI() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor.clear
    }
    
    // MARK: - Nodes
    
    private func addCircleLight() {
        let circleLight = AnimationCircleLight()
        circleLight.size = frame.size
        
        addChild(circleLight)
    }
    
    private func addCircleRay() {
        let circle = AnimationRay(circleRadius: frame.width / 2 - (rayRadius / 2) - 5, speed: raySpeed, rayRadius: rayRadius, rayLenght: rayLenght)
        circle.addTo(scene: self)
        
        rays.append(circle)
    }
    
    private func addOvalRays() {
        for i in 0..<Int(rayCount) {
            let rotation: CGFloat = (CGFloat.pi / (rayCount + 1)) * CGFloat(i)
            let clocwise: Bool = i % 2 == 0
            let speed: CGFloat = CGFloat.random(in: (raySpeed - (raySpeed / 4))..<(raySpeed + (raySpeed / 4)))
            let ray = AnimationRay(petalNumber: 2, spacing: 6, clockwise: clocwise, radius: frame.width / 2 - (rayRadius / 2) - 5, rotation: rotation, speed: speed, rayRadius: rayRadius, rayLenght: rayLenght - (rayLenght / 1.8))
            
            ray.addTo(scene: self)
            
            rays.append(ray)
        }
    }
    
    // MARK: - SpriteKit
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        for ray in rays {
            ray.updateNodesPosition()
        }
    }
    
    // MARK: - States
    
    internal func setNormalState() {
        for ray in rays {
            ray.setNormalState()
        }
    }
    
    internal func setThinkingState() {
        for ray in rays {
            ray.setThinkingState()
        }
    }
    
}
