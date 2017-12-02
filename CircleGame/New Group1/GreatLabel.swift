//
//  GreatLabel.swift
//  CircleGame
//
//  Created by Rus Razvan on 02/12/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class GreatLabel: SKLabelNode {
    func initialize() {
        self.name = "GreatLabel"
        self.position = CGPoint(x: 50, y: 0)
        self.fontSize = 50
        self.fontColor = SKColor.black
        self.alpha = 0.8
        self.zPosition = ZPositionService.shared.labels
        self.zRotation = 1
        self.text = "Great!"
    }
    
    func animate() {
        let zoomIn = SKAction.scale(to: 2, duration: 1)
        let zoomOut = SKAction.scale(to: 1, duration: 1)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([zoomIn,zoomOut,remove])
        self.run(sequence)
    }
}
