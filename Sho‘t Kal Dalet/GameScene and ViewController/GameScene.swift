//
//  GameScene.swift
//  Sho‘t Kal Dalet
//
//  Created by Taennan Rickman on 21/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit
import GameplayKit


// This func adds a space in the debugger
func makeSpace(_ lines: Int) { for _ in 0...lines - 1 { print(" ") } }

// FONTS // This and the following are put here to be accesed globally
let herculanum: String = "Herculanum"
let helvetica: String = "Helvetica"

let standardFont: String = herculanum


// SCENE SIZE //
var sceneWidth: CGFloat = 0
var sceneHeight: CGFloat = 0

// Scenes' meter equivalent
let meter = sceneWidth / 100


// SCORE COUNTER //
var score: Int = 0


// DIFFICULTY //
var difficulty: Difficulty = .increasing

enum Difficulty {
    case increasing
    case easy
    case medium
    case hard
}


// BITMASKS //
let bitmask = Bitmask()

struct Bitmask {                    // Int equivalents
    let shell: UInt32 = 0x1 << 0    // 1
    let enemy: UInt32 = 0x1 << 1    // 2
    let scene: UInt32 = 0x1 << 2    // 4
}


// BACKGROUNDS //
let gameBG = SKSpriteNode(texture: tex.gameBGTex)
let menuBG = SKSpriteNode(texture: tex.menuBGTex)


// LAYERS // The child layers will be added to the scene via the parent layers
let menuLayer = SKNode()
let leaderboardsLayer = SKNode()
let settingsLayer = SKNode()

let gameLayer = SKNode()
let pauseLayer = SKNode()


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        
        // Sets scene width and height
        sceneWidth = self.frame.width
        sceneHeight = self.frame.height
        
        print("Scene width = \(sceneWidth)")
        print("Scene height = \(sceneHeight)")
        
        
        // CONTACT DELEGATE //
        physicsWorld.contactDelegate = self
        
        
        // SHELL CATCHER //
        let shellCatcher = SKPhysicsBody.init(edgeLoopFrom: CGRect(x: -sceneWidth / 2, y: -sceneHeight, width: sceneWidth * 2, height: sceneHeight * 1.5) )
        shellCatcher.categoryBitMask = bitmask.scene
        shellCatcher.contactTestBitMask = bitmask.shell
        self.physicsBody = shellCatcher
        
        
        // TRACKING AREA //
        let trackArea = NSTrackingArea(
            rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: sceneWidth, height: sceneHeight)),
            options: [.activeInKeyWindow, .mouseMoved],
            owner: skTank,    // Tells where to send mouseMoved messages to
            userInfo: nil)
        
        view.addTrackingArea(trackArea)
        
        
        // MENUS //
        
        // Background
        menuBG.size = CGSize(width: self.frame.width * 2, height: self.frame.height)
        menuBG.position = CGPoint(x: 0, y: 0)
        menuBG.zPosition = 2
        self.addChild(menuBG)

        // Menu Layer
        menuLayer.zPosition = menuBG.zPosition + 1
        menuLayer.addChild(mL)

        // Settings Layer
        settingsLayer.position = CGPoint(x: -self.frame.width * 2, y: 0)
        settingsLayer.zPosition = menuLayer.zPosition

        // Leaderboards Layer
        leaderboardsLayer.position = CGPoint(x: self.frame.width * 2, y: 0)
        leaderboardsLayer.zPosition = menuLayer.zPosition
        
        
        self.addChild(menuLayer)
        self.addChild(settingsLayer)
        self.addChild(leaderboardsLayer)
        
        
        // BATTLEFIELD //
        
        // Background
        gameBG.size = CGSize(width: sceneWidth, height: sceneHeight)
        gameBG.position = CGPoint(x: 0, y: 0)
        
        // Game Layer
        gameLayer.position = CGPoint(x: 0, y: -sceneHeight)
        gameLayer.zPosition = 1
        
        // Pause Layer
        pauseLayer.position = gameLayer.position
        pauseLayer.zPosition = gameLayer.zPosition + 1
        
        
        self.addChild(gameLayer)
        self.addChild(pauseLayer)

        
    }
    
    
    // Fires gun
    override func mouseDown(with event: NSEvent) {
        // Returns if game is paused, in wrong layer or reloading
        guard gameLayer.isPaused == false else { return }
        guard gameLayer.position == CGPoint(x: 0, y: 0) else { return }
        guard skTank.isArmed else { return }
        
        // Initializes shell
        let shell = Shell()
        gameLayer.addChild(shell)
            
        // Applies impulses to shell
        trigFunc.scaleVectors(byPoint: skTank.realPoint, toVelcity: shell.velocity, forBody: shell)
        
        // Stops tank from firing (temporarily)
        skTank.reload()
        
    }
    
    
    // Calls on contactHandler to respond to physics contacts
    func didBegin(_ contact: SKPhysicsContact) { contactHandler.respond(to: contact) }
    
}
