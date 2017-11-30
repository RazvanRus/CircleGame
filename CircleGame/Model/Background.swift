//
//  Background.swift
//  CircleGame
//
//  Created by Rus Razvan on 28/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    func initialize(withPosition position: Int) {
        createBackground(withPosition: position)
    }
    
    func createBackground(withPosition position: Int) {
        self.name = "Background"
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: CGFloat(position) * self.size.width, y: 0)
        self.zPosition = 0
    }
}
