//
//  GameScene.swift
//  Telur
//
//  Created by boy setiawan on 02/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //let backgroundNode = SKSpriteNode(imageNamed: "background")
    let secondBackgroundNode = SKSpriteNode(imageNamed: "second")
    let bottomNode = SKSpriteNode(imageNamed: "bottom")
    
    
    let foregroundNode = SKSpriteNode()
    var egg:Egg!
    let coreMotionManager = CMMotionManager()
    
    let startGameTextNode = SKLabelNode(fontNamed: "Copperplate")
    var winGameTextNode:SKLabelNode!
    var loseGameTextNode:SKLabelNode!
    
    var statusOfWinning = false
    
    func addTitle(){
        startGameTextNode.fontSize = 40
        startGameTextNode.text = "Tap anywhere to start!"
        startGameTextNode.horizontalAlignmentMode = .center
        startGameTextNode.verticalAlignmentMode = .center
        startGameTextNode.fontColor = .red
        startGameTextNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(startGameTextNode)
    }
    
    func showWin(){
        winGameTextNode = SKLabelNode(fontNamed: "Copperplate")
        winGameTextNode.fontSize = 40
        winGameTextNode.text = "You Win!"
        winGameTextNode.horizontalAlignmentMode = .center
        winGameTextNode.verticalAlignmentMode = .center
        winGameTextNode.fontColor = .red
        winGameTextNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(winGameTextNode)
    }
    
    func showLose(){
        loseGameTextNode = SKLabelNode(fontNamed: "Copperplate")
        loseGameTextNode.fontSize = 40
        loseGameTextNode.text = "You Lost!"
        loseGameTextNode.horizontalAlignmentMode = .center
        loseGameTextNode.verticalAlignmentMode = .center
        loseGameTextNode.fontColor = .red
        loseGameTextNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(loseGameTextNode)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        isUserInteractionEnabled = true
        physicsWorld.contactDelegate = self
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node!
        let nodeB = contact.bodyB.node!
        
        if nodeA.name == "batu" && nodeB.name == "egg"{
            showWin()
            statusOfWinning = true
        }
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        scene?.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundColor = SKColor(ciColor: .white)
        
        addChild(foregroundNode)
        
        //addBackground()
        addSecondBackground()
        addBottom()
        
        let SIZE_CONST = size.width / 10
        
        var boxEngine = BoxVerticalStacker(boxSize: SIZE_CONST, scene: self, initialHeight: bottomNode.size.height,parent:foregroundNode)
        
        boxEngine.stackBoxes(level: 1)
        egg = boxEngine.placeEgg(level: 1)
        
        addTitle()
        
    }
    
//    func addBackground(){
//        // adding the background
//        backgroundNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//        addChild(backgroundNode)
//        
//    }
    func addSecondBackground(){
        // adding the second background
        secondBackgroundNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        //secondBackgroundNode.alpha = 1
        secondBackgroundNode.zPosition = -1
        addChild(secondBackgroundNode)
        
    }
    func addBottom(){
        // adding the background
        bottomNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        bottomNode.size.height = bottomNode.size.height * 2
        addChild(bottomNode)
        
    }
    
    override func didSimulatePhysics() {
        if let accelerometerData = coreMotionManager.accelerometerData {
            egg.physicsBody!.velocity =
                CGVector(dx: CGFloat(accelerometerData.acceleration.x * 150.0),
                         dy: egg.physicsBody!.velocity.dy)
            
            
        }
        
        if egg.position.x < -(egg.size.width / 2) {
            egg.position =
                CGPoint(x: size.width - egg.size.width / 2,
                        y: egg.position.y)
            
        }else if egg.position.x > self.size.width {
            egg.position = CGPoint(x: egg.size.width / 2,
                                          y: egg.position.y);
        }
    }
    
    deinit {
        coreMotionManager.stopAccelerometerUpdates()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if egg.position.y < 0{
            if !statusOfWinning{
                showLose()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !egg.physicsBody!.isDynamic{
            egg.physicsBody?.isDynamic = true
            
            coreMotionManager.accelerometerUpdateInterval = 0.3
            coreMotionManager.startAccelerometerUpdates()
            
            startGameTextNode.removeFromParent()
        }
    }
}
