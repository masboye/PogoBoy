//
//  GameScene.swift
//  Telur
//
//  Created by boy setiawan on 02/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //let backgroundNode = SKSpriteNode(imageNamed: "background")
    let secondBackgroundNode = SKSpriteNode(imageNamed: "second")
    let bottomNode = SKSpriteNode(imageNamed: "bottom")
    
    
    let foregroundNode = SKSpriteNode()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        isUserInteractionEnabled = true
        
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
        
        let boxEngine = BoxVerticalStacker(boxSize: SIZE_CONST, scene: self, initialHeight: bottomNode.size.height,parent:foregroundNode)
        
        boxEngine.stackBoxes(level: 1)
        
        
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
}
