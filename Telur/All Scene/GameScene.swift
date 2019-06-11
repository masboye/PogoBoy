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

class GameScene: SKScene {
    
    //let backgroundNode = SKSpriteNode(imageNamed: "background")
    let secondBackgroundNode = SKSpriteNode(imageNamed: "second")
    let bottomNode = SKSpriteNode(imageNamed: "bottom")
    
    
    let foregroundNode = SKSpriteNode()
    var egg:Egg!
    let coreMotionManager = CMMotionManager()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        isUserInteractionEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        

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
        
        coreMotionManager.accelerometerUpdateInterval = 0.3
        coreMotionManager.startAccelerometerUpdates()
        
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
    
}
