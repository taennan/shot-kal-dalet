//
//  SKTank.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 25/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Object for players' tank
let skTank = SKTank()

class SKTank: SKNode {
    
    // Nodes
    let hull = SKSpriteNode(imageNamed: "SKHull")
    let turret = SKSpriteNode(imageNamed: "SKTurret")
    
    // Location of mouse in view
    var mouseLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    // Point turret is aimed at
    var realPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    // Reload rate
    var isArmed: Bool = true
    var rof: TimeInterval = 0.6
    
    
    override init() {
        
        // Sets sprite sizes and positions //
        hull.size = CGSize(width: meter * 9.8, height: meter * 3.38)
        hull.position = CGPoint(x: -sceneWidth * 0.4, y: 0)
        
        turret.size = hull.size
        turret.position = hull.position
        turret.zPosition = hull.zPosition + 2
        
        
        super.init()
        
        // Adds children
        addChild(hull)
        addChild(turret)
        
        zPosition = gameLayer.zPosition + 2
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Temporarily prevents tank from firing
    func reload() {
        isArmed = false
        DispatchQueue.main.asyncAfter(deadline: .now() + rof, execute: { self.isArmed = true })
        
    }
    
    
    // Turns turret with mouse
    override func mouseMoved(with event: NSEvent) {
        mouseLocation = event.location(in: gameLayer)
        
        // Gets angle relative to skTurret position
        realPoint = CGPoint(x: (mouseLocation.x) - (turret.position.x), y: (mouseLocation.y) - (turret.position.y) )
        let angle = atan2(realPoint.y, realPoint.x)
        
        // Rotates the Arrow
        let rotate = SKAction.rotate(toAngle: angle, duration: 0)
        turret.run(rotate)
    }
    
    
    
}
