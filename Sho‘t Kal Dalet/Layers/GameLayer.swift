//
//  GameLayer.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 11/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Object for where the magic happens
let gL = GameLayer()

class GameLayer: SKNode {
    
    var gameStarted: Bool = false
    
    var spawnFrequency: TimeInterval = 2.5
    var timesIterated: Double = 0
    let freqModifier: TimeInterval = 0.1
    
    var enemiesHit: Int = 0
    
    override init() {
        super.init()
        addChild(skTank)
        addChild(gameBG)
        
        name = "Game Layer"
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Does what it says
    func startGame() {
        
        // Resets gameLayer and score
        gameStarted = true
        removeEnemies()
        score = 0
        // Plays gameLayer
        pauseFunc.pauseGameLayer(false)
        
        // Runs actions for pauseButton
        pauseLayer.addChild(pauseButton)
        let buttonSequence = SKAction.sequence([pauseFunc.immediateFade, pauseFunc.fadeIn])
        pauseButton.run(buttonSequence)
        pauseButton.isUserInteractionEnabled = true
        
        
        // Countdown //
        
        // Label
        let label = SKLabelNode()
        label.position = CGPoint(x: 0, y: -50)
        label.zPosition = self.zPosition + 1
        label.fontName = standardFont
        label.fontSize = 100
        label.fontColor = .white
        var textNum = -1
        let textArray = ["3", "2", "1", "GO!"]
        
        // Base actions
        let wait = SKAction.wait(forDuration: 0.8)
        let scale = SKAction.scale(by: 3, duration: wait.duration)
        let instaScale = SKAction.scale(by: 3, duration: 0)
        
        let actBlock = SKAction.run {
            
            // Sets label text
            textNum += 1
            label.text = textArray[textNum]
            print(label.text!)
            
            // Runs scaling action
            let scaleSeq = SKAction.sequence([scale, instaScale.reversed()])
            label.run(scaleSeq)
            
        }
        
        let singleAct = SKAction.sequence([actBlock, wait])
        let repeatAct = SKAction.repeat(singleAct, count: 4)
        // Runs countdown then spawns enemies
        let spawn = SKAction.run { self.startSpawning() }
        let sequence = SKAction.sequence([wait, repeatAct, .removeFromParent(), spawn])
        
        
        // Adds label and runs actions
        self.addChild(label)
        label.run(sequence)
        
        print("Game started. Difficulty is \(difficulty)")
        
    }
    
    // Does what it says
    func endGame() {
        
        // TEST
        timesIterated = 0
        
        // Shows and modifies pause layer
        gameStarted = false
        pauseFunc.showPauseLayer()
        pL.gameLabel.text = "Game Over"
        pL.exitButton.removeFromParent()
        
        print("Game ended. Score: \(score)")
        
    }
    
    // Spawns an enemy in game layer
    func spawnEnemy() {
        
        // Randomizes enemy type
        let enemy: Enemy
        let randInt = Int.random(in: 0...100)
        
        if randInt < 50 {                               // Spawns T-54
            enemy = Enemy(type: .t54)
        } else if randInt > 50 && randInt < 80 {        // Spawns T-62
            enemy = Enemy(type: .t62)
        } else {                                        // Spawns BMP-1
            enemy = Enemy(type: .bmp)
        }
        
        // Adds enemy to game layer and sets it moving
        self.addChild(enemy)
        enemy.physicsBody?.applyImpulse(CGVector(dx: -enemy.tankSpeed, dy: 0) )
        
    }

    
    // Spawning sequence
    func startSpawning() {
        
        // Base actions
        var wait: SKAction
        let add = SKAction.run {
            // Randomizes amount of enemies spawned simultaneously
            var repeatLoop: Int
            let randAmount = Int.random(in: 0...100)
            
            if randAmount < 60 {
                repeatLoop = 0                              // One enemy spawned
            } else if randAmount > 60 && randAmount < 95 {
                repeatLoop = 1                              // Two enemies spawned
            } else {
                repeatLoop = 2                              // Three enemies spawned
            }
            
            for _ in 0...repeatLoop { self.spawnEnemy() }
            
            // Sets the amount of times enemies were added
            self.timesIterated += 1
        }
        
        
        switch difficulty {
        case .increasing:
            print("Decreasing loop started")
            
            // Creates array to append to and hold the list of actions
            var actionCycle: [SKAction] = []
            
            
            // Creates and fills a range to store spawning frequencies
            var time: TimeInterval = spawnFrequency
            let lowerBound: TimeInterval = 1
            
            var timeRange: [TimeInterval] = []
            while time > lowerBound {
                timeRange.append(time)
                time -= freqModifier
            }
            
            // Creates a spawning loop with decreasing spawning intervals and appends to actionCycle
            for t in timeRange {
                // Appends an addEnemy action to actionCycle
                actionCycle.append(add)
                // Creates and appends a new wait action to actionCycle
                wait = SKAction.wait(forDuration: t)
                print("Spawn frequency: \(wait.duration)")
                actionCycle.append(wait)
            }
            
            
            // Creates a standard spawning loop and appends to actionCycle
            wait = SKAction.wait(forDuration: 1)
            let seq = SKAction.sequence([add, wait])
            let loop = SKAction.repeatForever(seq)
            actionCycle.append(loop)
            
            // A printing action for the debugger
            let prt = SKAction.run { print("Standard loop started. Spawn frequency: 1") }
            actionCycle.append(prt)
            
            
            // Runs actionCycle
            self.run(SKAction.sequence(actionCycle))
            
        default:
            print("Standard loop started")
            print("Spawn frequency: \(spawnFrequency)")
            
            wait = SKAction.wait(forDuration: spawnFrequency)
            
            let seq = SKAction.sequence([add, wait])
            self.run(SKAction.repeatForever(seq))
        }

    }
    
    
    // Removes all enemies from game layer
    func removeEnemies() {
        self.removeAllChildren()
        self.addChild(gameBG)
        self.addChild(skTank)
    }
    
    
}
