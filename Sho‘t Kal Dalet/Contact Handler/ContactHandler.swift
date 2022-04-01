//
//  ContactHandler.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 30/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Responds to physics contacts in gameLayer
let contactHandler = ContactHandler()

class ContactHandler: NSObject {
    
    func respond(to contact: SKPhysicsContact) {
        
        let bodyOne: SKPhysicsBody
        let bodyTwo: SKPhysicsBody
        
        // Ensures that bodyOne.categoryBitmask is smaller than bodyTwo.categoryBitmask
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyOne = contact.bodyA
            bodyTwo = contact.bodyB
        } else {
            bodyOne = contact.bodyB
            bodyTwo = contact.bodyA
        }
        
        // Runs category bitmasks through OR gate
        let actionKey: UInt32 = bodyOne.categoryBitMask | bodyTwo.categoryBitMask
        
        // Decides how to respond to contact
        switch actionKey {
        case bitmask.shell | bitmask.enemy:     // Shell and enemy contact
            contFunc.tankHit(with: bodyOne.node as! Shell, target: bodyTwo.node as! Enemy)
        
        case bitmask.shell | bitmask.scene:     // Shell and scene contact
            contFunc.sceneHit(with: bodyOne.node as! Shell)
        
        case bitmask.enemy | bitmask.scene:     // Enemy and scene contact
            // Guards against ending the game twice if two enemies hit
            guard gL.gameStarted else { return } 
            
            gL.endGame()
            
        default:
            print("No valid action key for this contact")
        }
        
    }
    
    
}
