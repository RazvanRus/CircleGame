//
//  MainMenuScene.swift
//  CircleGame
//
//  Created by Rus Razvan on 27/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        initialize()
    }
    
    func initialize() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "PlayButton" {
                presentGamePlayScene()
            }
            if atPoint(location).name == "NoAds" {
                print("@#$#@!#@$")
            }
        }
    }
    
    func presentGamePlayScene() {
        if let gameplayScene = GameplayScene(fileNamed: "GameplayScene") {
            // scale mode .fill to adapt iPhone X
            if IphoneTypeService.shared.isIphoneX() {
                gameplayScene.scaleMode = .fill
            } else {
                gameplayScene.scaleMode = .aspectFill
            }
            self.view?.presentScene(gameplayScene, transition: SKTransition.crossFade(withDuration: TimeInterval(0.5)))
        }
    }
}
