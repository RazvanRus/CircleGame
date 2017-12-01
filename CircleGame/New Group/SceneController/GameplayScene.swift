//
//  GameplayScene.swift
//  CircleGame
//
//  Created by Rus Razvan on 27/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    let circle = Circle()
    
    var scoreLabel: SKLabelNode?
    
    var circleCanBeginScaleing = true
    var circleIsMoving = false
    var canMoveToMainMenu = false
    
    override func didMove(to view: SKView) {
        initialize()
        initializeDelegateNotifications()
        physicsWorld.contactDelegate = self
    }
    
    func initialize() {
        scoreLabel = self.childNode(withName: "ScoreLabel") as? SKLabelNode
        ObstacleService.shared.resetDistanceBetween()
        
        createObstacle()
        createCircle()
        createBackground()
        createGround()
    }
    
    func presentMainMenu() {
        if let mainMenu = MainMenuScene(fileNamed: "MainMenuScene") {
            mainMenu.scaleMode = .aspectFill
            self.view?.presentScene(mainMenu, transition: SKTransition.crossFade(withDuration: TimeInterval(0.5)))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if circleIsMoving {
            moveBackground()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canMoveToMainMenu { presentMainMenu() }
        if circleCanBeginScaleing {
            circle.scale()
        }else if circleIsMoving {
            circle.scale()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if circleCanBeginScaleing {
            if circleIsBigEnought() {
                moveCircle()
                
            } else {
                circleScaleFailed()
            }
        }else if circleIsMoving {
            circle.stopScale()
        }
    }
    
    func circleIsBigEnought() -> Bool {
        return circle.size.height >= CircleService.shared.minSize
    }
    
    func circleScaleFailed() {
        circle.stopScale()
        circle.scaleBack()
    }
    
    func increaseScore() {
        if let scoreText = scoreLabel?.text,
            let score = Int(scoreText) {
            scoreLabel?.text = "\(score+1)"
        }
    }
    
    func adjustObstacleDistance() {
        let difference = ObstacleService.shared.distanceBetween - (0.1 * ObstacleService.shared.distanceBetween) - circle.size.height
        if difference > 0 {
            ObstacleService.shared.distanceBetween -= difference
        } else if ObstacleService.shared.distanceBetween < 100 {
            ObstacleService.shared.distanceBetween -= 1
        }
    }
}



// MARK: creating stufs extension
extension GameplayScene {
    func createCircle() {
        circle.initialize()
        circle.setPosition(CGPoint(x: CircleService.shared.startingPoint, y: 0))
        circle.circleDelegate = self
        self.addChild(circle)
    }
    
    func createBackground() {
        for i in 0...2 {
            let background = Background(imageNamed: "Background")
            background.initialize(withPosition: i)
            self.addChild(background)
        }
    }
    
    func createGround() {
        for i in 0...2 {
            let ground = Ground(imageNamed: "Ground")
            ground.initialize(withPosition: i, withHeight: self.frame.height)
            self.addChild(ground)
        }
    }
    
    func createObstacle() {
        let currentObstacle = Obstacle()
        currentObstacle.initialize(withDistance: ObstacleService.shared.distanceBetween)
        let position = randomObstaclePosition()
        currentObstacle.setPosition(position)
        self.addChild(currentObstacle)
    }
    
    func createNextObstacle() {
        let nextObstacle = Obstacle()
        nextObstacle.initialize(withDistance: ObstacleService.shared.distanceBetween)
        var position = randomObstaclePosition()
        position.x -=  CircleService.shared.startingPoint - CircleService.shared.endingPoint // out of screen
        nextObstacle.setPosition(position)
        self.addChild(nextObstacle)
    }
    
    func randomObstaclePosition() -> CGPoint {
        let firstXNumber = ObstacleService.shared.minXPosition
        let secoundXNumber = ObstacleService.shared.maxXPosition
        let firstYNumber = ObstacleService.shared.minYPosition
        let secoundYNumber = ObstacleService.shared.maxYPosition
        let xPosition = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstXNumber - secoundXNumber) + min(firstXNumber, secoundXNumber)
        let yPosition = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstYNumber - secoundYNumber) + min(firstYNumber, secoundYNumber)
        return CGPoint(x: xPosition, y: yPosition)
    }
}


// MARK: moving things extension
extension GameplayScene {
    func moveCircle() {
        circle.stopScale()
        circle.animate(to: CircleService.shared.endingPoint)
        
        circleCanBeginScaleing = false
        circleIsMoving = true
    }
    
    func moveBackground() {
        enumerateChildNodes(withName: "Background", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
        }))
    }
    
    func moveGround() {
        enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            node.run(SKAction.moveBy(x: CircleService.shared.startingPoint - CircleService.shared.endingPoint, y: 0, duration: CircleService.shared.moveBackAnimationDuration))
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
        }))
    }
    
    func moveObstacles() {
        enumerateChildNodes(withName: "Obstacle", using: ({
            (node, error) in
            node.run(SKAction.moveBy(x:  CircleService.shared.startingPoint - CircleService.shared.endingPoint, y: 0, duration: CircleService.shared.moveBackAnimationDuration))
            if node.position.x < -(self.frame.width) {
                node.removeFromParent()
            }
        }))
    }
}


// MARK: End Game Situation
extension GameplayScene {
    func endGameSituation() {
        self.isPaused = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { self.canMoveToMainMenu = true })
        
        if let scoreText = scoreLabel?.text,
            let score = Int(scoreText){
            if GameService.shared.getHighscore() < score {
                GameService.shared.set(highscore: score)
            }
            createEndGamePannel(withScore: score)
        } else {
            createEndGamePannel(withScore: 0)
        }
    }
    
    func createEndGamePannel(withScore score: Int) {
        let endGamePannel = EndGamePannel()
        endGamePannel.initialize(withScore: score)
        self.addChild(endGamePannel)
    }
}

// MARK: phisics contact delegate extension
extension GameplayScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secoundBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Circle" {
            firstBody = contact.bodyA
            secoundBody = contact.bodyB
        } else if contact.bodyB.node?.name == "Circle" {
            firstBody = contact.bodyB
            secoundBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Circle" && secoundBody.node?.name == "ObstaclePartUp" {
            endGameSituation()
        }
    }
}


// MARK: Circle delegate extension
extension GameplayScene: CircleDelegate {
    func circleFinishedMoving() {
        circleIsMoving = false
        
        increaseScore()
        adjustObstacleDistance()
        createNextObstacle()
        
        circle.stopScale()
        circle.animateBack(to: CircleService.shared.startingPoint)
        moveObstacles()
        moveGround()
    }
    
    func circleFinishedMovingBack() {
        circleCanBeginScaleing = true
    }
}


// MARK: extension for delegate notifications (app state)
extension GameplayScene {
    func initializeDelegateNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(GameplayScene.appDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameplayScene.appWillResignActive), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    @objc
    func appDidBecomeActive() {
        circle.stopScale()
    }
    
    @objc
    func appWillResignActive() {
        
    }
}






