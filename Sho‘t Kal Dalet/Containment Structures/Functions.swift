//
//  Contact Actions.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 30/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import Foundation
import SpriteKit


// Contains trig. and vector functions
let trigFunc = Trigonometry()

struct Trigonometry {
    
    // Does what it says
    func getHypotenuse(forPoint: CGPoint) -> Double {
        return Double(sqrt( (forPoint.x * forPoint.x) + (forPoint.y * forPoint.y) ))
    }
    
    // Scales a CGPoint vector to appropriate length and applies impulse
    func scaleVectors(byPoint: CGPoint, toVelcity: Double, forBody: SKSpriteNode) {
        let hyp = getHypotenuse(forPoint: byPoint)
        let difference = toVelcity / hyp
        
        forBody.physicsBody?.applyImpulse( CGVector(dx: Double(byPoint.x) * difference, dy: Double(byPoint.y) * difference) )
    }
    
}


// Contains functions for physics contacts
let contFunc = ContactFuncs()

struct ContactFuncs {
    
    // Called during shell and enemy contact
    func tankHit(with shell: Shell, target: Enemy) { shell.detonate(aginst: target) }
    
    // Called during shell and scene contact
    func sceneHit(with shell: SKSpriteNode) { shell.removeFromParent() }
    
}


// Contains functions which control pause layer
let pauseFunc = PauseFuncs()

struct PauseFuncs {
    
    // Base Actions
    let fade = SKAction.fadeOut(withDuration: 0.5)
    let fadeIn = SKAction.fadeIn(withDuration: 0.5)
    let immediateFade = SKAction.fadeOut(withDuration: 0)
    
    let move = SKAction.move(by: CGVector(dx: 0, dy: sceneHeight), duration: 0.5)
    
    
    // Pauses or plays gameLayer
    func pauseGameLayer(_ pause: Bool) {
        
        if pause == true {
            // Pauses gameLayer
            gameLayer.isPaused = true
            gameLayer.scene?.physicsWorld.speed = 0
        } else {
            // Plays gameLayer
            gameLayer.isPaused = false
            gameLayer.scene?.physicsWorld.speed = 1
        }
        
    }
    
    
    // Does what it says
    func hidePauseLayer() {
        
        // Plays gameLayer
        pauseGameLayer(false)
        
        // Runs actions for pauseButton
        pauseLayer.addChild(pauseButton)
        let buttonSequence = SKAction.sequence([immediateFade, fadeIn])
        pauseButton.run(buttonSequence)
        pauseButton.isUserInteractionEnabled = true
        
        // Runs actions for pauseLayer and removes from parent
        let sequence = SKAction.sequence([move.reversed(), .removeFromParent()])
        pL.run(sequence)
        
    }
    
    
    // Does what it says
    func showPauseLayer() {
        
        // Adds pL to scene
        pauseLayer.addChild(pL)
        
        // Runs actions
        pauseGameLayer(true)
        pL.run(move)
        
        // Runs actions for pauseButton
        let buttonSequence = SKAction.sequence([fade, .removeFromParent()])
        pauseButton.run(buttonSequence)
        pauseButton.isUserInteractionEnabled = false
        
        print("Game paused")
        
    }
    
    
}

