//
//  EnemyTank.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 26/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


enum EnemyType {
    case t54
    case bmp
    case t62
}


class Enemy: SKSpriteNode {
    
    // Tank properties
    let tankTex: SKTexture
    var health: Int
    let tankSpeed: Double
    let tankSize: CGSize
    
    let spawnPos: CGPoint
    
    let physBody: SKPhysicsBody
    
    var points: Int
    let trackedPoints = 5
    
    // Time it takes to repair tracked vehicle
    let repairTime: TimeInterval = 2
    
    
    init(type: EnemyType) {
        
        // Initializes tank
        switch type {
        case .bmp:
            tankTex = tex.bmp
            health = 1
            tankSpeed = 50
            tankSize = CGSize(width: meter * 6.735, height: meter * 2.94)
            points = 25
            
        case .t54:
            tankTex = tex.t54
            health = 1
            tankSpeed = 35
            tankSize = CGSize(width: meter * 9, height: meter * 3.37)
            points = 10
            
        case .t62:
            
            fallthrough
        default:
            tankTex = tex.t62
            health = 2
            tankSpeed = 40
            tankSize = CGSize(width: meter * 9.34, height: meter * 3.3)
            points = 5
            
        }
        
        // Sets spawn position within appropriate range
        let randY = CGFloat.random(in: (-sceneHeight / 2 + (tankSize.height * 2))...(sceneHeight / 2 - (tankSize.height * 2)) )
        spawnPos = CGPoint(x: sceneWidth / 2 + tankSize.width, y: randY)
        
        // Sets physics body
        physBody = SKPhysicsBody(rectangleOf: tankSize)
        physBody.affectedByGravity = false
        physBody.allowsRotation = false
        physBody.categoryBitMask = bitmask.enemy
        physBody.collisionBitMask = bitmask.scene
        physBody.contactTestBitMask = bitmask.shell | bitmask.scene
        
        
        super.init(texture: tankTex, color: .clear, size: tankSize)
        
        // Sets some stuff
        texture = tankTex
        position = spawnPos
        zPosition = skTank.turret.zPosition - 1
        
        // Adds physics body
        self.physicsBody = physBody
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    
    // Spawns enemy in gameLayer
    func spawn() {
        
        gL.addChild(self)
        self.physicsBody?.applyImpulse(CGVector(dx: -tankSpeed, dy: 0) )
        
    }
    
    
    // Adds points to score
    func addPoints() {
        score += points
        pL.scoreLabel.text = String(score)
    }
    
    
    // Displays points gained in game layer
    func displayPoints() {
        
        // Initializes label
        let pointLabel = SKLabelNode(text: "+ \(points)" )
        pointLabel.position = self.position
        pointLabel.zPosition = self.zPosition + 1
        pointLabel.fontName = standardFont
        pointLabel.fontSize = 50
        pointLabel.fontColor = .white
        
        // Determines movement
        let direction: CGVector
        
        if self.position.y < 0 {
            direction = CGVector(dx: 0, dy: self.size.height * 2)
        } else {
            direction = CGVector(dx: 0, dy: -self.size.height * 2)
        }
        
        // Actions
        let fade = SKAction.fadeOut(withDuration: 1)
        let move = SKAction.move(by: direction, duration: 1)
        let remove = SKAction.removeFromParent()
        
        let group = SKAction.group([fade, move])
        let sequence = SKAction.sequence([group, remove])
        
        // Adds label to game layer and runs actions
        gL.addChild(pointLabel)
        pointLabel.run(sequence)
        
    }
    
    
    // Called when shell has impacted
    func wasHit() {
        
        // Shows points gained
        displayPoints()
        
        // Removes any physicss affecting self
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        health -= 1
        
        // Responds according to remaining health
        if health > 0 {     // Changes to a tracked T-62
            self.texture = tex.trackedTex[Int.random(in: 0...1)]
            addPoints()
            points += 15
            repair()
            
        } else {            // Destroys self
            addPoints()
            gL.enemiesHit += 1
            self.removeFromParent()
            
        }
        
    }
    
    
    // Repairs tracked vehicle after delay
    func repair() {
        
        // Runs after repair time has completed
        DispatchQueue.main.asyncAfter(deadline: .now() + repairTime, execute: {
            
            // Changes texture
            let changeTex = SKAction.setTexture(tex.t62)
            self.run(changeTex)
            
            // Resets health and points and sets self moving
            self.points -= 15
            self.health += 1
            self.physicsBody?.applyImpulse(CGVector(dx: -self.tankSpeed, dy: 0))
            
        })
        
    }
    
    
}
