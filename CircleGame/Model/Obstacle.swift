//
//  Obstacle.swift
//  CircleGame
//
//  Created by Rus Razvan on 27/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class Obstacle: SKNode {
    func initialize(withDistance distance: CGFloat) {
        self.zPosition = ZPositionService.shared.obstacle
        self.name = "Obstacle"
        
        let partsHeight = ((750-distance)/2 + 1) * 2
        createPartUp(withHeight: partsHeight)
        createPartDown(withHeight: partsHeight)
        createPerfectPart(withYPosition: distance/2)
        createRamp(withHeight: partsHeight)
    }
    
    func setPosition(_ position: CGPoint) {
        self.position = position
    }
    
    func createPartUp(withHeight height: CGFloat) {
        let partUp = SKSpriteNode(imageNamed: "Obstacle")
        let yPosition = (750-height)/2 + 1 + height/2
        
        partUp.name = "ObstaclePartUp"
        partUp.color = .black
        partUp.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        partUp.position = CGPoint(x: 0, y: yPosition)
        partUp.size = CGSize(width: 30, height: height)
        partUp.zRotation = CGFloat(Double.pi)

        partUp.physicsBody = SKPhysicsBody(rectangleOf: partUp.size)
        partUp.physicsBody?.categoryBitMask = ColliderType.Obstacle
        partUp.physicsBody?.affectedByGravity = false
        partUp.physicsBody?.isDynamic = false
        
        self.addChild(partUp)
    }
    
    func createPartDown(withHeight height: CGFloat) {
        let partDown = SKSpriteNode(imageNamed: "Obstacle")
        let yPosition = (750-height)/2 + 1 + height/2

        partDown.name = "ObstaclePartDown"
        partDown.color = .black
        partDown.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        partDown.position = CGPoint(x: 0, y: -yPosition)
        partDown.size = CGSize(width: 30, height: height)
        
        partDown.physicsBody = SKPhysicsBody(rectangleOf: partDown.size)
        partDown.physicsBody?.categoryBitMask = ColliderType.Obstacle
        partDown.physicsBody?.affectedByGravity = false
        partDown.physicsBody?.isDynamic = false
        
        self.addChild(partDown)
    }
    
    func createPerfectPart(withYPosition yPosition: CGFloat) {
        let perfectPart = SKSpriteNode()
        let height = ObstacleService.shared.distanceBetween * 0.05
        
        perfectPart.name = "ObstaclePerfect"
        perfectPart.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        perfectPart.position = CGPoint(x: 0, y: yPosition-(height/2))
        perfectPart.size = CGSize(width: 5, height: height)
        
        perfectPart.physicsBody = SKPhysicsBody(rectangleOf: perfectPart.size)
        perfectPart.physicsBody?.categoryBitMask = ColliderType.Perfect
        perfectPart.physicsBody?.collisionBitMask = 0
        perfectPart.physicsBody?.affectedByGravity = false
        perfectPart.physicsBody?.isDynamic =  false
        
        self.addChild(perfectPart)
    }
    
    func createRamp(withHeight height: CGFloat) {
        let ramp = SKSpriteNode(imageNamed: "Ramp")
        let yPosition = (750-height)/2 + 1 + height/2

        ramp.name = "Ramp"
        ramp.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ramp.size = CGSize(width: height*2, height: height)
        ramp.position = CGPoint(x: -ramp.size.width/2 - 15, y: -yPosition)
        
        ramp.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Ramp"),
                                         size: CGSize(width: ramp.size.width, height: ramp.size.height))
        ramp.physicsBody?.affectedByGravity = false
        ramp.physicsBody?.isDynamic = false
        ramp.physicsBody?.categoryBitMask = ColliderType.Ground
        
        self.addChild(ramp)
    }
}
