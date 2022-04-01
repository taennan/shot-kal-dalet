//
//  MenuLayer.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 24/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


let mL = MenuLayer()

class MenuLayer: SKNode {
    
    // Nodes
    let title = SKLabelNode(text: "Sho't Kal Dalet")
    let toSett = LayerChanger(from: menuLayer, to: settingsLayer, textShown: "Settings")
    let toLead = LayerChanger(from: menuLayer, to: leaderboardsLayer, textShown: "Leaderboards")
    let play = LayerChanger(from: menuLayer, to: gameLayer, textShown: "Battle!")
    
    override init() {
        
        // Game Title
        title.fontSize = 110
        title.fontName = standardFont
        title.fontColor = .white
        title.position = CGPoint(x: 0, y: (sceneHeight) / 5)
        
        // Navigation Buttons
        toSett.fontSize = 40
        toSett.fontColor = .lightGray
        toSett.position = CGPoint(x: -sceneWidth / 6, y: -sceneHeight / 5)
        
        toLead.fontSize = toSett.fontSize
        toLead.fontColor = toSett.fontColor
        toLead.position = CGPoint(x: -toSett.position.x, y: toSett.position.y)
        
        play.fontSize = 60
        play.fontColor = title.fontColor
        play.position = CGPoint(x: 0, y: -sceneHeight / 3)
        
        super.init()
        
        // Adds nodes as children
        addChild(title)
        addChild(toSett)
        addChild(toLead)
        addChild(play)
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
