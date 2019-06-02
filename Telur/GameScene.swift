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
    
    let backgroundNode = SKSpriteNode(imageNamed: "background")
    let secondBackgroundNode = SKSpriteNode(imageNamed: "second")
    let bottomNode = SKSpriteNode(imageNamed: "bottom")
    
    let foregroundNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        scene?.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundColor = SKColor(ciColor: .white)
        
        //addBackground()
        addSecondBackground()
        addBottom()
    }
    
    func addBackground(){
        // adding the background
        backgroundNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        addChild(backgroundNode)
        
    }
    func addSecondBackground(){
        // adding the second background
        secondBackgroundNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        //secondBackgroundNode.alpha = 1
        addChild(secondBackgroundNode)
        
    }
    func addBottom(){
        // adding the background
        bottomNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        addChild(bottomNode)
        
    }
}
