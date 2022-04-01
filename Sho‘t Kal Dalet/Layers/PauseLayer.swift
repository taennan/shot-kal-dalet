//
//  PauseLayer.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 4/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


let pL = PauseLayer()

// Layer revealed when game is over or paused
class PauseLayer: SKNode {
    
    // Layer backdrop
    let backdrop = SKSpriteNode(texture: tex.pauseBGTex)
    
    // Buttons
    let exitButton = ExitButton()
    let menuButton = MenuButton()
    let restart = RestartButton()
    
    // Labels
    let gameLabel = SKLabelNode(text: "Game Paused")
    let scoreLabel = SKLabelNode()
    let label = SKLabelNode(text: "SCORE:")
    
    override init() {
        
        backdrop.size = CGSize(width: sceneWidth / 2, height: sceneHeight / 2)
        
        exitButton.position = CGPoint(x: (sceneWidth / 4) - exitButton.size.width, y: (sceneHeight / 4) - exitButton.size.height)
        exitButton.zPosition = gameLayer.zPosition + 2
        
        restart.position = CGPoint(x: 0, y: -sceneHeight / 8)
        restart.zPosition = exitButton.zPosition
        restart.fontName = standardFont
        restart.fontSize = 35
        restart.fontColor = .brown
        
        menuButton.position = CGPoint(x: 0, y: -sceneHeight / 5)
        menuButton.zPosition = exitButton.zPosition
        menuButton.fontSize = 40
        menuButton.fontColor = restart.fontColor
        
        gameLabel.position = CGPoint(x: 0, y: 75)
        gameLabel.zPosition = exitButton.zPosition
        gameLabel.fontName = standardFont
        gameLabel.fontSize = 60
        gameLabel.fontColor = .white
        
        scoreLabel.position = CGPoint(x: sceneWidth / 12, y: 25)
        scoreLabel.zPosition = exitButton.zPosition
        scoreLabel.fontName = standardFont
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = .white
        scoreLabel.text = String(score)
        
        label.position = CGPoint(x: -scoreLabel.position.x, y: scoreLabel.position.y)
        label.zPosition = exitButton.zPosition
        label.fontName = standardFont
        label.fontSize = scoreLabel.fontSize
        label.fontColor = .white
        
        
        super.init()
        
        // Adds children
        addChild(backdrop)
        addChild(exitButton)
        addChild(restart)
        addChild(menuButton)
        addChild(gameLabel)
        addChild(scoreLabel)
        addChild(label)
        
        position = CGPoint(x: 0, y: -sceneHeight)
        zPosition = gameLayer.zPosition + 1
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
