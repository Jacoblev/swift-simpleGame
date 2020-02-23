//
//  GameScene.swift
//  MyFirstGame
//
//  Created by Kobi Lev on 13/11/2018.
//  Copyright © 2018 Kobi Lev. All rights reserved.
//
import UIKit
import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var upLabel = SKLabelNode()
    var btmLabel = SKLabelNode()
    var gameover = SKLabelNode()
    var Score = [Int]()

  
    
    
    func StartGame(){
        
        
        
        Score = [0,0]
        upLabel.text = "\(Score[1])"
        btmLabel.text = "\(Score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
        
    }
    
    func AddScore(WhoWonTheRound : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if WhoWonTheRound == main {
            Score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        else if WhoWonTheRound == enemy
        {
            Score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        upLabel.text = "\(Score[1])"
        btmLabel.text = "\(Score[0])"
        
        if (upLabel.text == "10" || btmLabel.text == "10")
        {
            gameover.text = "Game Over"
            gameover.isHidden = false
            pausingGame()
        }
        else {
            gameover.isHidden = true
        }
    }
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        upLabel = self.childNode(withName: "upLabel") as! SKLabelNode
        btmLabel = self.childNode(withName: "btmLabel") as! SKLabelNode
        gameover = self.childNode(withName: "gameover") as! SKLabelNode
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        StartGame()
        upLabel.isHidden = true
        btmLabel.isHidden = true
        gameover.isHidden = true
        }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches
        {
            let location = touch.location(in: self)
            if currentGameType == .player2 {
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
            
            
        }
    }
    
    func pausingGame()
    {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    func gameContin()
    {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 10, dy: 10)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        self.becomeFirstResponder()
        
        switch currentGameType {
        case .Easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            
            break
        case .Medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
            
            break
        case .Hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
            
            break
        case .player2:
        
            break
            
        }
        
        
        
        
        
        if ball.position.y <= main.position.y - 30
        {
            AddScore(WhoWonTheRound: enemy)
          
            upLabel.isHidden = false
            
          
        }
 
        else if ball.position.y >= enemy.position.y + 30
        {
            AddScore(WhoWonTheRound: main)
            btmLabel.isHidden = false
        }
     
    }
}
