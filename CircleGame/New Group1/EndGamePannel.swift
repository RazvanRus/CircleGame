//
//  EndGamePannel.swift
//  CircleGame
//
//  Created by Rus Razvan on 01/12/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit
//import Appodeal

class EndGamePannel: SKSpriteNode {
    func initialize(withScore score: Int) {
        createPannel()
        createTextLabel()
        createScoreLabel(withScore: score)
        createQuitLabel()
    }
    
    func createPannel() {
        self.name = "EndGamePannel"
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 0, y: 0)
        self.size = CGSize(width: 1334, height: 750)
        self.zPosition = 20
        self.color = SKColor.black
        self.alpha = 0.8
    }
    
    func createTextLabel() {
        let textLabel = SKLabelNode()
        textLabel.name = "EndGamePannelLabel"
        textLabel.position = CGPoint(x: 0, y: 250)
        textLabel.fontSize = 120
        textLabel.fontColor = SKColor.white
        textLabel.alpha = 0.8
        textLabel.text = "Game Over"
        self.addChild(textLabel)
    }
    
    func createScoreLabel(withScore score: Int) {
        let scoreLabel = SKLabelNode()
        scoreLabel.name = "EndGamePannelScoreLabel"
        scoreLabel.position = CGPoint(x: 0, y: 75)
        scoreLabel.fontSize = 120
        scoreLabel.fontColor = SKColor.white
        scoreLabel.alpha = 0.8
        scoreLabel.text = "\(score)"
        self.addChild(scoreLabel)
    }
    
    func createQuitLabel() {
        let quitLabel = SKLabelNode()
        quitLabel.name = "EndGamePannelQuitLabel"
        quitLabel.position = CGPoint(x: 0, y: -250)
        quitLabel.fontSize = 90
        quitLabel.fontColor = SKColor.white
        quitLabel.alpha = 1
        quitLabel.text = "Tap to quit"
        self.addChild(quitLabel)
        
        let initialFadeIn = SKAction.fadeAlpha(to: 0.6, duration: 0.5)
        
        let fadeIn = SKAction.fadeAlpha(to: 0.6, duration: 1)
        let fadeOut = SKAction.fadeAlpha(to: 0.2, duration: 1)
        
        let sequence = SKAction.sequence([fadeOut,fadeIn])
        let repeatFade = SKAction.repeatForever(sequence)
        
        quitLabel.run(SKAction.sequence([initialFadeIn,repeatFade]))
    }
    
    func createReviveLabel() {
        let reviveLabel = SKLabelNode()
        reviveLabel.name = "EndGamePannelReviveLabel"
        reviveLabel.position = CGPoint(x: 0, y: -100)
        reviveLabel.fontSize = 90
        reviveLabel.fontColor = SKColor.white
        reviveLabel.alpha = 0.6
        reviveLabel.text = "Tap to revive"
        
//        if ReviveGameService.shared.canPlayerBeRevived {
//            if Appodeal.isReadyForShow(with: .rewardedVideo) {
//                self.addChild(reviveLabel)
//            }
//        }
    }
}

