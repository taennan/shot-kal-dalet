//
//  LeaderboardsLayer.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 24/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


let leadL = LeaderboardsLayer()

class LeaderboardsLayer: SKNode {
    
    // Nodes
    let title = SKLabelNode(text: "Leaderboards")
    let done = LayerChanger(from: leaderboardsLayer, to: menuLayer, textShown: "Done")
    
    
    override init() {
        
        // Layer Title
        title.position = CGPoint(x: 0, y: (sceneHeight / 7) * 2 )
        title.fontSize = 70
        title.fontName = standardFont
        title.fontColor = sL.title.fontColor
        
        // Navigation button
        done.position = CGPoint(x: 0, y: -title.position.y)
        done.fontSize = 40
        done.fontName = standardFont
        done.fontColor = sL.done.fontColor
        
        
        super.init()
        
        // Adds nodes as children
        addChild(title)
        addChild(done)
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
