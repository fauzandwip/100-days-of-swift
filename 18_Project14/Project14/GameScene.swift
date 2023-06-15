//
//  GameScene.swift
//  Project14
//
//  Created by Fauzan Dwi Prasetyo on 06/05/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameScore: SKLabelNode!
    var gameOver: SKSpriteNode!
    var restart: SKLabelNode!
    
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var slots = [WhackSlot]()
    var popupTime = 0.85
    var numRounds = 0
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.blendMode = .replace
        background.position = CGPoint(x: 512, y: 384)
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 20, y: 20)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        restart = SKLabelNode(fontNamed: "Chalkduster")
        restart.text = "Restart"
        restart.position = CGPoint(x: 20, y: 700)
        restart.horizontalAlignmentMode = .left
        restart.zPosition = 1
        addChild(restart)
        
        createSlots()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createEnemy()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let positon = touch.location(in: self)
        let nodesTapped = nodes(at: positon)
        
        if nodesTapped.contains(restart) {
            self.restartTapped()
        }
        
        // for sure the correct node is WhackSlot
        // for node in tappedNodes {
        //            guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
        //            if !whackSlot.isVisible { continue }
        //            if whackSlot.isHit { continue }
        
        let charNode = nodesTapped[0]
        
        guard let whackSlot = charNode.parent?.parent as? WhackSlot else { return }
        if !whackSlot.isVisible { return }
        if whackSlot.isHit { return }
        
        whackSlot.hit()
        
        if let smoke = SKEmitterNode(fileNamed: "smoke") {
            smoke.position = CGPoint(x: 0, y: 40)
            smoke.zPosition = 1
            whackSlot.addChild(smoke)
        }
        
        if charNode.name == "charFriend" {
            score -= 5
            
            run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
        } else if charNode.name == "charEnemy" {
            score += 1
            
            whackSlot.charNode.xScale = 0.85
            whackSlot.charNode.yScale = 0.85
            
            run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
        }
        
        
    }
    
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        
        addChild(slot)
        slots.append(slot)
    }
    
    func createSlots() {
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410))}
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320))}
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230))}
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140))}
    }
    
    func createEnemy() {
        numRounds += 1
        
        if numRounds > 30 {
            for slot in slots {
                slot.hit()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.createGameOver()
            }
            
            return
        }
        
        popupTime *= 0.991
        
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        
        if Int.random(in: 0...12) > 4 { slots[1].show(hideTime: popupTime)}
        if Int.random(in: 0...12) > 8 { slots[2].show(hideTime: popupTime)}
        if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime)}
        if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime)}
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2.0
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.createEnemy()
        }
    }
    
    func createGameOver() {
        gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.name = "gameOver"
        gameOver.position = CGPoint(x: 512, y: 384)
        gameOver.zPosition = 2
        addChild(gameOver)
        
        let finalScore = SKLabelNode(fontNamed: "Chalkduster")
        finalScore.text = "Final Score: \(score)"
        finalScore.fontSize = 40
        finalScore.zPosition = 2
        finalScore.position = CGPoint(x: 0, y: -50)
        finalScore.verticalAlignmentMode = .top
    
        gameOver.addChild(finalScore)
        
        run(SKAction.playSoundFileNamed("gameover.mp3", waitForCompletion: false))
    }
    
    func restartTapped() {
        score = 0
        numRounds = 0
        popupTime = 0.85
        
        for slot in slots {
            slot.charNode.position = CGPoint(x: 0, y: -90)
        }
        
        //        gameOver.run(SKAction.removeFromParent())
        self.enumerateChildNodes(withName: "gameOver") { node, stop in
            node.run(SKAction.removeFromParent())
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createEnemy()
        }
    }
    
}
