//
//  AnimationCircleLight.swift
//  Alison
//
//  Created by Benjamin Pisano on 29/05/2019.
//  Copyright © 2019 Snopia. All rights reserved.
//

import SpriteKit

internal class AnimationCircleLight: SKSpriteNode {
    
    init() {
        let texture = SKTexture(image: UIImage(named: "Light_circle", in: Bundle(for: AnimationCircleLight.self), compatibleWith: nil)!)
        super.init(texture: texture, color: UIColor.white, size: CGSize.zero)
        configureLight()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLight() {
        lightingBitMask = AnimationLight.Mask.circleLight
    }
    
}
