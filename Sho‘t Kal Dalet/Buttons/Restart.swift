//
//  Restart.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 13/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Object for restarting game from pause layer
class RestartButton: SKLabelNode {
    
    override init() {
        super.init()
        isUserInteractionEnabled = true
        text = "Restart"
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Restarts Game
    override func mouseUp(with event: NSEvent) {
        
        // Resets pause layer and score
        pauseButton.removeFromParent()
        pauseFunc.hidePauseLayer()
        pauseButton.removeFromParent()
        score = 0
        pL.scoreLabel.text = String(score)
        pL.gameLabel.text = "Game Paused"
        pL.addChild(pL.exitButton)
        
        // Resets game layer
        gL.removeEnemies()
        gL.removeAllActions()
        gL.startGame()
        
    }
    
    
}
