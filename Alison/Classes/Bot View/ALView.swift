//
//  ALView.swift
//  Alison
//
//  Created by Benjamin Pisano on 28/05/2019.
//  Copyright © 2019 Snopia. All rights reserved.
//

import UIKit

@IBDesignable
public final class ALView: UIView {
    
    private var contentView: ALContentView?
    
    @IBInspectable public var raySpeed: CGFloat = 4.2 { didSet { loadScene() } }
    @IBInspectable public var rayRadius: CGFloat = 8 { didSet { loadScene() } }
    @IBInspectable public var rayLenght: CGFloat = 5 { didSet { loadScene() } }
    @IBInspectable public var rayCount: CGFloat = 3 { didSet { loadScene() } }
    
    @IBInspectable public var normalPrimaryColor: UIColor = UIColor(red: 17/255, green: 255/255, blue: 137/255, alpha: 1) { didSet { updateUI() } }
    @IBInspectable public var normalSecondaryColor: UIColor? = UIColor(red: 86/255, green: 216/255, blue: 255/255, alpha: 1) { didSet { updateUI() } }
    @IBInspectable public var thinkingPrimaryColor: UIColor = UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1) { didSet { updateUI() } }
    @IBInspectable public var thinkingSecondaryColor: UIColor? = UIColor(red: 0/255, green: 255/255, blue: 202/255, alpha: 1) { didSet { updateUI() } }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        configureContentView()
        configureUI()
        
        DispatchQueue.main.async {
            self.loadScene()
        }
    }
    
    private func configureUI() {
        backgroundColor = UIColor.clear
    }
    
    private func configureContentView() {
        guard let contentView = UINib(nibName: "AlisonContentView", bundle: Bundle(for: ALView.self)).instantiate(withOwner: self, options: nil).first as? ALContentView else {
            return
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        self.contentView = contentView
    }
    
    private func loadScene() {
        contentView?.loadScene(raySpeed: raySpeed, rayRadius: rayRadius, rayLenght: rayLenght, rayCount: rayCount)
    }
    
    // MARK: - Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        applyCorner()
    }
    
    private func applyCorner() {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
    
    // MARK: - Appearance
    
    public func setNormalState() {
        contentView?.scene?.setNormalState()
    }
    
    public func setThinkingState() {
        contentView?.scene?.setThinkingState()
    }
    
    private func updateUI() {
        guard let scene = contentView?.scene else {
            return
        }
        
        for ray in scene.rays {
            ray.normalPrimaryColor = normalPrimaryColor
            ray.normalSecondaryColor = normalSecondaryColor
            ray.thinkingPrimaryColor = thinkingPrimaryColor
            ray.thinkingSecondaryColor = thinkingSecondaryColor
        }
    }

}
