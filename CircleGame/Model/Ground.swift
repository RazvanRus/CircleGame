//
//  Ground.swift
//  CircleGame
//
//  Created by Rus Razvan on 28/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class Ground: SKSpriteNode {
    func initialize(withPosition position: Int, withHeight height: CGFloat) {
        createGround(withPosition: position, withHeight: height)
    }
    
    func createGround(withPosition position: Int, withHeight height: CGFloat) {
        self.name = "Ground"
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: CGFloat(position) * self.size.width, y: -(height / 2) - 50)
        self.zPosition = ZPositionService.shared.ground
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = ColliderType.Ground
    }
}
