//
//  Textures.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 30/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Contains textures used throughout the game
let tex = Textures()

struct Textures {
    
    // SHELL //
    
    // Standard
    let apRound = SKTexture(imageNamed: "Shell")
    // Explosion Array
    var expArr: [SKTexture] = [
        SKTexture(imageNamed: "BAM!"),      // 0
        SKTexture(imageNamed: "BANG!"),     // 1
        SKTexture(imageNamed: "BOOM!"),     // 2
        SKTexture(imageNamed: "DONK!"),     // 3
        SKTexture(imageNamed: "KA-POW!"),   // 4
        SKTexture(imageNamed: "POW!"),      // 5
    ]
    // Ricochet Array
    var ricoArr: [SKTexture] = [
        SKTexture(imageNamed: "BOING!"),    // 0
        SKTexture(imageNamed: "TING!")      // 1
    ]
    
    
    // SHO'T KAL TANK //
    
    // Turret
    let turretTex = SKTexture(imageNamed: "SKTurret")
    // Hull
    let hullTex = SKTexture(imageNamed: "SKHull")
    
    
    // ENEMY TANKS //
    
    // T-54
    let t54 = SKTexture(imageNamed: "T-54")
    // BMP-1
    let bmp = SKTexture(imageNamed: "BMP-1")
    // T-62
    let t62 = SKTexture(imageNamed: "T-62")
    
    let trackedTex: [SKTexture] = [
        SKTexture(imageNamed: "T-62 LeftTracked"),    // 0
        SKTexture(imageNamed: "T-62 RightTracked")    // 1
    ]
    
    
    // BACKGROUNDS AND BACKDROPS //
    
    // Game Layer background
    let gameBGTex = SKTexture(imageNamed: "GameBackground")
    // Menu Layer background
    let menuBGTex = SKTexture(imageNamed: "MenuBackground")
    
    // Pause Layer backdrop
    let pauseBGTex = SKTexture(imageNamed: "Backdrop")
    
    
    // BUTTONS //
    
    let exitTex = SKTexture(imageNamed: "ExitButton")
    let pauseTex = SKTexture(imageNamed: "PauseButton")
    
    
}

