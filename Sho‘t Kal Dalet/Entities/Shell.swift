//
//  Shell.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 30/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Object for projectiles
class Shell: SKSpriteNode {
    
    // Shell size
    let caliber = skTank.hull.size.height / 5
    
    // Muzzle velocity
    let velocity: Double = 60
    
    // Damage caused to enemies
    let damage: Int = 1
    
    
    init() {
        
        super.init(texture: tex.apRound, color: .clear, size: CGSize(width: caliber * 4, height: caliber))
        
        position = skTank.turret.position
        zPosition = skTank.turret.zPosition - 1
        zRotation = skTank.turret.zRotation
        
        // Initializes physics body
        let physBody = SKPhysicsBody(rectangleOf: self.size)
        physBody.affectedByGravity = false
        physBody.allowsRotation = false
        physBody.categoryBitMask = bitmask.shell
        physBody.collisionBitMask = bitmask.scene
        physBody.contactTestBitMask = bitmask.enemy | bitmask.scene
        self.physicsBody = physBody
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Detonates shell
    func detonate(aginst target: Enemy) {
        
        // Informs target of impact
        target.wasHit()
        
        // Removes physics body
        self.physicsBody = nil
        
        // So explosion is not hidden by targets' texture
        self.zPosition = target.zPosition + 1
        
        // Size of explosion
        let expRad: CGSize = CGSize(width: self.size.width * 2, height: self.size.width * 2)
        
        // Changes to appropriate texture
        if target.health == 1 {
            self.texture = tex.ricoArr[Int.random(in: 0...1)]
            
        } else {
            self.texture = tex.expArr[Int.random(in: 0...5)]
            
        }
        
        
        // Runs explosion action and removes from parent
        self.size = CGSize(width: 1, height: 1)
        let scale = SKAction.scale(to: expRad, duration: 0.7)
        
        let remove = SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([scale, remove])
        self.run(sequence)
        
    }
    
    
}
