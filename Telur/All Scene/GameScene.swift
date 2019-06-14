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
    
    //var statusOfWinning = false
    var boxLeft = 3
    let boxLeftText = SKLabelNode(fontNamed: "CopperPlate")
    
    var startGame = false
    
    var countDown = 100
    var score = 0
    var level = 1
    private let INCREASE_LEVEL = 3
    
    func addScore(){
        
        
        boxLeftText.text = "Box Left : \(boxLeft) Time : \(countDown) Score : \(score)"
        boxLeftText.fontColor = .green
        boxLeftText.fontSize = 20
        boxLeftText.position = CGPoint(x: boxLeftText.fontSize * 2 , y: size.height - boxLeftText.fontSize - 50 )
        boxLeftText.horizontalAlignmentMode = .left
        addChild(boxLeftText)
        
    }
    
    func addTitle(){
        startGameTextNode.fontSize = 30
        startGameTextNode.text = "Tap anywhere to start!"
        startGameTextNode.horizontalAlignmentMode = .center
        startGameTextNode.verticalAlignmentMode = .center
        startGameTextNode.fontColor = .red
        startGameTextNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(startGameTextNode)
        startGameTextNode.zPosition = 10
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
        self.level = 0
        self.boxLeft = (level / self.INCREASE_LEVEL) + self.boxLeft
        self.score = 0
        
        self.countDown =  ((level / self.INCREASE_LEVEL) * 20) + self.countDown
        
    }
    
    func setup(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        isUserInteractionEnabled = true
        physicsWorld.contactDelegate = self
    }
    
    init(size: CGSize,level:Int,score:Int) {
        super.init(size: size)
        
        
        setup()
        self.level = level
        self.boxLeft = (level / self.INCREASE_LEVEL) + self.boxLeft
        self.score = score
        
        self.countDown =  ((level / self.INCREASE_LEVEL) * 20) + self.countDown
        //print(size)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node!
        let nodeB = contact.bodyB.node!
        
        print("\(nodeA.name) --> \(nodeB.name)")
        if nodeA.name == "batu" && nodeB.name == "egg"{
       
            self.score += self.countDown
            self.gameOverWithResult(true)
            
        }
        
        if (nodeA.name?.contains("box"))!  && (nodeB.name?.contains("box"))!{
            
            let box1 =  nodeA as! BoxSpriteNode
            let box2 = nodeB as! BoxSpriteNode
            
            //when the box collide
            if (!box1.intersects(box2)){
                print("intersect")
                box2.isUserInteractionEnabled = false
                box1.isUserInteractionEnabled = false
                
            }
            
            
        }
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        //print(size)
        scene?.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundColor = SKColor(ciColor: .white)
        
        addChild(foregroundNode)
        
        //addBackground()
        addSecondBackground()
        addBottom()
        
        let SIZE_CONST = size.width / 10
        
        var boxEngine = BoxVerticalStacker(boxSize: SIZE_CONST, scene: self, initialHeight: bottomNode.size.height,parent:foregroundNode)
        
        boxEngine.stackBoxes(level: self.level)
        egg = boxEngine.placeEgg(level: self.level)
        
        addTitle()
        addScore()
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
               
                    self.gameOverWithResult(false)
                
            }
        
        if countDown <= 0 {
            self.gameOverWithResult(false)
        }
            
            //get list of all children and check it's position
            
            foregroundNode.enumerateChildNodes(withName: "*box") { (node, stop) in
                let box = node as! BoxSpriteNode
                if box.position.y < 0 {
                    //print("\(box.name) is out of bounds")
                    if self.boxLeft > 0 {
                        if self.startGame{
                            box.removeFromParent()
                            self.boxLeft -= 1
                            self.score -= 20
                            self.boxLeftText.text = "Box Left : \(self.boxLeft) Time : \(self.countDown) Score : \(self.score)"
                            //print("started")
                        }else{
                            //print("Not started")
                            box.removeFromParent()
                        }
                        
                    }else{
                        self.gameOverWithResult(false)
                    }
                    
                }
            }
        
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !startGame{
            egg.physicsBody?.isDynamic = true
            
            coreMotionManager.accelerometerUpdateInterval = 0.3
            coreMotionManager.startAccelerometerUpdates()
            
            startGameTextNode.removeFromParent()
            
            //get list of all children and check it's position
            
            foregroundNode.enumerateChildNodes(withName: "*box") { (node, stop) in
                let box = node as! BoxSpriteNode
                //box.physicsBody?.isDynamic = true
                box.isUserInteractionEnabled = true
            }
            
            startGame = true
            
             Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDown(_:)), userInfo: nil, repeats: true)
        }
    }
    
    @objc func countDown(_ timer:Timer){
        
        self.countDown -= 1
        self.boxLeftText.text = "Box Left : \(self.boxLeft) Time : \(self.countDown) Score : \(self.score)"
    }
    
    func gameOverWithResult(_ result: Bool){
        
       
        let transition = SKTransition.crossFade(withDuration: 2.0)
        let menuScene = MenuScene(size: size,
                                  gameResult: result,
                                  score: score,level: level)
        view?.presentScene(menuScene, transition: transition)
        
    }
}
