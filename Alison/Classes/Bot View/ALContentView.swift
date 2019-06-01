//
//  ALContentView.swift
//  Alison
//
//  Created by Benjamin Pisano on 28/05/2019.
//  Copyright © 2019 Snopia. All rights reserved.
//

import UIKit
import SpriteKit

internal class ALContentView: UIView {

    @IBOutlet private weak var animationView: SKView!
    
    internal var scene: AnimationScene? {
        return animationView.scene as? AnimationScene
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = UIColor.clear
        animationView.backgroundColor = UIColor.clear
    }
    
    internal func loadScene(raySpeed: CGFloat, rayRadius: CGFloat, rayLength: CGFloat, rayCount: CGFloat) {
        clearScene()
        
        let animationScene = AnimationScene()
        animationScene.raySpeed = raySpeed
        animationScene.rayRadius = rayRadius
        animationScene.rayLength = rayLength
        animationScene.rayCount = rayCount
        animationScene.scaleMode = .resizeFill
        
        animationView.allowsTransparency = true
        animationView.presentScene(animationScene)
    }
    
    private func clearScene() {
        animationView.scene?.removeAllActions()
        animationView.scene?.removeFromParent()
    }
    
}
