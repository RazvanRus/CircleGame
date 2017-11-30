//
//  Circle.swift
//  CircleGame
//
//  Created by Rus Razvan on 27/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Circle: UInt32 = 1
    static let Obstacle: UInt32 = 2
    static let Ground: UInt32 = 3
    static let Score: UInt32 = 4
}

class Circle: SKSpriteNode {
    func initialize() {
        createCircle()
    }

    func createCircle() {
        self.name = "Circle"
        self.texture = SKTexture(imageNamed: "circle")
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = CGSize(width: CircleService.shared.initialSize, height: CircleService.shared.initialSize)
        self.zPosition = 3
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height/2)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = ColliderType.Circle
        self.physicsBody?.collisionBitMask = ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Obstacle | ColliderType.Score
    }
    
    func setPosition(_ position: CGPoint) {
        self.position = position
    }
    
    func scale() {
        let scaleAction = SKAction.scale(to: CircleService.shared.maxScale, duration: CircleService.shared.scaleDuration)
        let moveAction = SKAction.moveBy(x: CircleService.shared.scaleMovementX, y: CircleService.shared.scaleMovementY, duration: CircleService.shared.scaleDuration)
        let group = SKAction.group([scaleAction,moveAction])
        self.run(group, withKey: "scaleAction")
    }
    
    func scaleBack() {
        self.run(SKAction.scale(to: CircleService.shared.initialScale, duration: CircleService.shared.scaleFailedDuration))
        self.run(SKAction.moveTo(x: CircleService.shared.startingPoint, duration: CircleService.shared.scaleFailedDuration))
    }
    
    func stopScale() {
        self.removeAction(forKey: "scaleAction")
    }
    
    func animateCircle(to xPosition: CGFloat) {
        let rotateAction = SKAction.rotate(byAngle: CircleService.shared.animationAngleRotation, duration: CircleService.shared.moveAnimationDuration)
        let moveAction = SKAction.moveTo(x: xPosition, duration: CircleService.shared.moveAnimationDuration)
        let group = SKAction.group([rotateAction,moveAction])
        self.run(group)
    }
    
    func animateCircleBack(to xPosition: CGFloat) {
        let moveAction = SKAction.moveTo(x: xPosition, duration: CircleService.shared.moveBackAnimationDuration)
        let resizeAction = SKAction.scale(to: CircleService.shared.initialScale, duration: CircleService.shared.moveBackAnimationDuration)
        let group = SKAction.group([moveAction,resizeAction])
        self.run(group)
    }
}


















