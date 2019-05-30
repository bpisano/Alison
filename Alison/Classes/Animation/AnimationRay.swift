//
//  AnimationRay.swift
//  Alison
//
//  Created by Benjamin Pisano on 28/05/2019.
//  Copyright © 2019 Snopia. All rights reserved.
//

import UIKit
import SpriteKit

internal class AnimationRay: NSObject {
    
    private enum State {
        
        case normal
        case thinking
        
    }
    
    private static let radiusMutliplier: CGFloat = 4
    private static let speedMultiplier: CGFloat = 10

    private var node: SKSpriteNode
    private var lightNode: AnimationLight
    private var emitter: SKEmitterNode
    private var shape: AnimationPath.Shape
    
    private var speed: CGFloat
    private var rayRadius: CGFloat
    private var rayLenght: CGFloat
    
    private var state: AnimationRay.State = .normal
    
    internal var normalPrimaryColor: UIColor = UIColor(red: 17/255, green: 255/255, blue: 137/255, alpha: 1) {
        didSet {
            applyColors()
        }
    }
    internal var normalSecondaryColor: UIColor? = UIColor(red: 86/255, green: 216/255, blue: 255/255, alpha: 1) {
        didSet {
            applyColors()
        }
    }
    internal var thinkingPrimaryColor: UIColor = UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1) {
        didSet {
            applyColors()
        }
    }
    internal var thinkingSecondaryColor: UIColor? = UIColor(red: 0/255, green: 255/255, blue: 202/255, alpha: 1) {
        didSet {
            applyColors()
        }
    }
    
    // MARK: - Init
    
    init(circleRadius: CGFloat, speed: CGFloat, rayRadius: CGFloat, rayLenght: CGFloat) {
        self.lightNode = AnimationLight(color: UIColor.white)
        self.shape = .circle
        self.rayRadius = rayRadius * AnimationRay.radiusMutliplier
        self.rayLenght = rayLenght
        self.speed = speed * AnimationRay.speedMultiplier
        
        let texture = SKTexture(image: UIImage(named: "Ray_spark", in: Bundle(for: AnimationRay.self), compatibleWith: nil)!)
        self.node = SKSpriteNode(texture: texture)
        
        let emitterPath = Bundle(for: AnimationRay.self).path(forResource: "RayParticle", ofType: "sks")!
        let emitterData = FileManager.default.contents(atPath: emitterPath)!
        self.emitter = NSKeyedUnarchiver.unarchiveObject(with: emitterData) as! SKEmitterNode
        
        super.init()
        
        configureUI()
        
        let path = AnimationPath.circle(radius: circleRadius)
        startAnimation(path: path)
    }
    
    init(petalNumber: CGFloat = 2, spacing: CGFloat = 16, clockwise: Bool = true, radius: CGFloat, rotation: CGFloat, speed: CGFloat, rayRadius: CGFloat, rayLenght: CGFloat) {
        self.lightNode = AnimationLight(color: UIColor.white)
        self.shape = .oval
        self.rayRadius = rayRadius * AnimationRay.radiusMutliplier
        self.rayLenght = rayLenght
        self.speed = speed * AnimationRay.speedMultiplier
        
        let texture = SKTexture(image: UIImage(named: "Ray_spark", in: Bundle(for: AnimationRay.self), compatibleWith: nil)!)
        self.node = SKSpriteNode(texture: texture)
        
        let emitterPath = Bundle(for: AnimationRay.self).path(forResource: "RayParticle", ofType: "sks")!
        let emitterData = FileManager.default.contents(atPath: emitterPath)!
        self.emitter = NSKeyedUnarchiver.unarchiveObject(with: emitterData) as! SKEmitterNode
        
        super.init()
        
        configureUI()
        
        let path = AnimationPath.rose(rotation: rotation, radius: radius, petalNumber: petalNumber, spacing: spacing, clockwise: clockwise)
        startAnimation(path: path)
    }
    
    // MARK: - UI
    
    private func configureUI() {
        node.size = CGSize(width: rayRadius / 2, height: rayRadius / 2)
        node.alpha = 0.3
        
        if shape == .circle {
            emitter.zPosition = 10
        } else {
            emitter.zPosition = 5
        }
        
        emitter.particleTexture = SKTexture(image: UIImage(named: "Ray_sphere", in: Bundle(for: AnimationRay.self), compatibleWith: nil)!)
        emitter.particleSize = CGSize(width: rayRadius, height: rayRadius)
        
        applyColors()
        setNormalState()
    }
    
    private func startAnimation(path: UIBezierPath) {
        let followAction = SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: speed)
        let followForever = SKAction.repeatForever(followAction)
        
        node.position = path.currentPoint
        node.run(followForever)
    }
    
    private func applyColors() {
        if state == .normal {
            setEmittersColors(primary: normalPrimaryColor, secondary: normalSecondaryColor)
        } else {
            setEmittersColors(primary: thinkingPrimaryColor, secondary: thinkingSecondaryColor)
        }
    }
    
    private func setEmittersColors(primary primaryColor: UIColor, secondary secondaryColor: UIColor?) {
        if let secondaryColor = secondaryColor {
            if state == .normal {
                emitter.particleColorSequence = SKKeyframeSequence(keyframeValues: [UIColor.white, primaryColor, secondaryColor], times: [0, 0.3, 1])
            } else {
                emitter.particleColorSequence = SKKeyframeSequence(keyframeValues: [UIColor.white, primaryColor, secondaryColor], times: [0, 0.1, 0.5])
            }
        } else {
            emitter.particleColorSequence = SKKeyframeSequence(keyframeValues: [UIColor.white, primaryColor], times: [0, 0.3])
        }
    }
    
    // MARK: - SpriteKit
    
    internal func addTo(scene: SKScene) {
        scene.addChild(node)
        scene.addChild(lightNode)
        scene.addChild(emitter)
    }
    
    internal func updateNodesPosition() {
        lightNode.position = node.position
        emitter.particlePosition = node.position
    }
    
    // MARK: - States
    
    internal func setNormalState() {
        state = .normal
        
        let speedAction = SKAction.speed(to: 1, duration: 1.5)
        speedAction.timingMode = .easeInEaseOut
        
        let completion = SKAction.run {
            if self.shape == .circle {
                self.emitter.particleAlphaSpeed = -1 / self.rayLenght
            } else {
                self.emitter.particleAlphaSpeed = -1 / (self.rayLenght + self.rayLenght / 4)
            }
            
            self.emitter.particleBirthRate = 120 + (self.speed / AnimationRay.speedMultiplier)
            self.emitter.particleLifetime = 1 / -self.emitter.particleAlphaSpeed
        }
        completion.timingMode = .easeInEaseOut
        
        node.removeAction(forKey: "speedUp")
        node.run(.group([speedAction, completion]), withKey: "speedDown")
        
        applyColors()
    }
    
    internal func setThinkingState() {
        state = .thinking
        
        if shape == .circle {
            emitter.particleAlphaSpeed = (-1 / rayLenght) * 3
        } else {
            emitter.particleAlphaSpeed = (-1 / (rayLenght + rayLenght / 4)) * 3
        }
        
        emitter.particleBirthRate = (120 + (speed / AnimationRay.speedMultiplier)) * 2
        emitter.particleLifetime = (1 / -emitter.particleAlphaSpeed) * 2
        
        node.removeAction(forKey: "speedDown")
        node.speed = (speed / AnimationRay.speedMultiplier) * 1.5
        
        applyColors()
    }
    
}
