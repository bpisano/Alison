//
//  AnimationLight.swift
//  Alison
//
//  Created by Benjamin Pisano on 29/05/2019.
//  Copyright © 2019 Snopia. All rights reserved.
//

import SpriteKit

internal class AnimationLight: SKLightNode {
    
    internal struct Mask {
        
        static let circleLight: UInt32 = 0x1 << 1
        
    }
    
    internal var color: UIColor {
        didSet {
            configureLight()
        }
    }
    
    init(color: UIColor) {
        self.color = color
        
        super.init()
        
        configureLight()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLight() {
        falloff = 4
        ambientColor = .black
        lightColor = .white
        categoryBitMask = Mask.circleLight
    }
    
}
