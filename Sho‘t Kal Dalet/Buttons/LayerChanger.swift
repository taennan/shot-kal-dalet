//
//  LayerChanger.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 22/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import GameplayKit
import SpriteKit


// Button used to transition between layers //
class LayerChanger: SKLabelNode {
    
    // NOTE: Could not put invCoord or moveBG here due to an Xcode bug
    
    // Layers to switch
    let currentLayer: SKNode
    let newLayer: SKNode
    
    // Time taken for actions to complete //
    let fadeTime: TimeInterval = 0.7
    let moveTime: TimeInterval = 1
    
    // Actions //
    let wait: SKAction
    
    let fade: SKAction
    let fadeIn: SKAction
    let immediateFade: SKAction
    
    
    init(from: SKNode, to: SKNode, textShown: String) {
        // Guards against inappropriate switches
        guard from != to else { fatalError("Attempted to switch a layer to itself") }
        
        currentLayer = from
        newLayer = to
        
        wait = SKAction.wait(forDuration: moveTime / 2)
        
        fade = SKAction.fadeOut(withDuration: fadeTime)
        fadeIn = SKAction.sequence([wait, fade.reversed()])
        immediateFade = SKAction.fadeOut(withDuration: 0.0)
        
        
        super.init()
        
        isUserInteractionEnabled = true
        text = textShown
        fontName = standardFont
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Removes current layer after delay
    func removeLayer(_ layer: SKNode, after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            layer.children[0].removeFromParent()
        })
        
    }
    
    
    // Switches the layer shown
    override func mouseUp(with event: NSEvent) {
        
        // Checks what new layer is and adds to scene
        switch newLayer {
        case settingsLayer:
            settingsLayer.addChild(sL)
        case menuLayer:
            menuLayer.addChild(mL)
        case leaderboardsLayer:
            leaderboardsLayer.addChild(leadL)
        case gameLayer:
            gameLayer.addChild(gL)

        default:
            return
        }
        
        // Inverse coordinates of the new layer
        let invCoord: CGPoint = CGPoint(x: -(newLayer.position.x), y: -(newLayer.position.y))
        
        // Background Action
        let moveBG = SKAction.move(by: CGVector(dx: invCoord.x / 4, dy: invCoord.y), duration: moveTime)
        
        // Grouped actions
        let moveCL = SKAction.move(to: invCoord, duration: moveTime)
        let moveNL = SKAction.move(to: currentLayer.position, duration: moveTime)
        
        // Action Groups
        let moveCurrent = SKAction.group([fade, moveCL])
        let moveNew: SKAction
        
        // Sets moveNew with appropriate actions
        if newLayer == gameLayer {
            moveNew = moveNL
            
            // Runs actions for pause layer and starts game
            pauseLayer.run(moveNew)
            DispatchQueue.main.asyncAfter(deadline: .now() + (moveTime * 0.8), execute: { gL.startGame() })
            
        } else {
            moveNew = SKAction.group([immediateFade, moveNL, fade.reversed()])
        }
        
        
        // Runs Actions
        menuBG.run(moveBG)
        newLayer.run(moveNew)
        currentLayer.run(moveCurrent)
        removeLayer(currentLayer, after: moveTime)
        
    }
    
    
}


// Object that switches specifically from gameLayer to menuLayer (in that order)
class MenuButton: LayerChanger {
    
    init() { super.init(from: gameLayer, to: menuLayer, textShown: "Main Menu") }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Switches layers
    override func mouseUp(with event: NSEvent) {

        // Inverse coordinates of new layer
        let invCoord = CGPoint(x: -(newLayer.position.x), y: -(newLayer.position.y))
        
        // Action that moves background
        let moveBG = SKAction.move(by: CGVector(dx: invCoord.x / 4, dy: invCoord.y), duration: moveTime)
        
        // Action groups
        let pauseBlock = SKAction.run { pL.gameLabel.text = "Game Paused" }
        let moveCurrent = SKAction.move(to: invCoord, duration: moveTime)
        let currentSeq = SKAction.sequence([moveCurrent, pauseBlock])
        let moveNL = SKAction.move(to: CGPoint(x: 0, y: 0), duration: moveTime)
        let moveNew = SKAction.group([fade.reversed(), moveNL])
        
        
        // Runs actions //
        menuBG.run(moveBG)
        newLayer.addChild(mL)
        newLayer.run(moveNew)
        
        pauseFunc.hidePauseLayer()
        pauseButton.removeFromParent()
        
        // Removes current enemies and stops spawning mechanism
        gL.removeEnemies()
        gL.removeAllActions()
        
        currentLayer.run(currentSeq)
        removeLayer(currentLayer, after: moveTime)
        
    }
    
    
}
