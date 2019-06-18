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


extension CGFloat {
    var radians: Float {
        return Float(self) * (Float.pi / 180)
    }
    
}

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
    var boxLeft = 2
    let boxLeftText = SKLabelNode(fontNamed: "CopperPlate")
    
    var startGame = false
    
    var countDown = 100
    var score = 0
    var level = 1
    private let INCREASE_LEVEL = 3
    let fire = SKEmitterNode(fileNamed: "fire")
    
    var cam:SKCameraNode!
    var swipeCount = 0
    var swipeSide = 0
    
    func addScore(){
        
        boxLeftText.text = "Box Left : \(boxLeft) Time : \(countDown) Score : \(score)"
        boxLeftText.fontColor = .white
        boxLeftText.fontSize = 20
        boxLeftText.position = CGPoint(x: boxLeftText.fontSize * 2 , y:  50 )
        boxLeftText.horizontalAlignmentMode = .left
        addChild(boxLeftText)
        boxLeftText.zPosition = 10
    }
    
    func addTitle(){
        
        if self.level == 1{
            startGameTextNode.fontSize = 20
            startGameTextNode.text = "Help Pogo Boy get to the platform \nMove the boxes to make way \nTap anywhere to start!"
            //startGameTextNode.lineBreakMode = .byWordWrapping
            startGameTextNode.numberOfLines = 0

        }else{
            startGameTextNode.fontSize = 30
            startGameTextNode.text = "Tap anywhere to start!"
        }
        
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
        self.level = 1
        self.boxLeft = (level / self.INCREASE_LEVEL) + self.boxLeft
        self.score = 0
        
        self.countDown =  ((level / self.INCREASE_LEVEL) * 20) + self.countDown
        
    }
    
    func setup(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        isUserInteractionEnabled = true
        physicsWorld.contactDelegate = self
        addChild(fire!)
        self.name = "gameScene"
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
        
        //print("\(nodeA.name) --> \(nodeB.name)")
        if nodeA.name == "batu" && nodeB.name == "egg"{
            
            self.score += self.countDown
            self.gameOverWithResult(true)
            
        }
        
        if (nodeA.name?.contains("box"))! && nodeB.name == "egg"{
            
            let egg = nodeB as! Egg
            
            egg.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 0.1))
            
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
        
        cam = SKCameraNode()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.camera = cam
        self.addChild(cam)
        
        let point = CGPoint(x: (size.width / 2), y: size.height / 2)
        self.camera?.position = point
        //print("\(self.camera?.position)")
        
        //self.camera?.position = CGPoint(x: -500, y: 0)
        
        let swipedDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDown))
        //swipedDown.direction = .down
        swipedDown.direction = .down
        view.addGestureRecognizer(swipedDown)
        
        let swipedUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeUp))
        //swipedDown.direction = .down
        swipedUp.direction = .up
        view.addGestureRecognizer(swipedUp)
        
        //        let swipedLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        //        //swipedDown.direction = .down
        //        swipedLeft.direction = .left
        //        view.addGestureRecognizer(swipedLeft)
        //
        //        let swipedRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        //        //swipedDown.direction = .down
        //        swipedRight.direction = .right
        //        view.addGestureRecognizer(swipedRight)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.boxRotate(_:)))
        view.addGestureRecognizer(rotateGesture)
        
    }
    
    @objc func boxRotate( _ recognizer : UIRotationGestureRecognizer){
        
       let point = abs((recognizer.rotation * 100).rounded())
       
        foregroundNode.enumerateChildNodes(withName: "*box") { (node, stop) in
            let box = node as! BoxSpriteNode
            
            if box.isSelected {
              //print("\(point)")
                //let oldAnchor = box.anchorPoint
                //print("\(oldAnchor)")
                box.anchorPoint = CGPoint(x:0.5,y: 0.5)
                //var rotate = SKAction.rotate(toAngle: point, duration: TimeInterval(1))
                //box.run(rotate)
                box.zRotation = CGFloat(point.radians)
                box.anchorPoint = CGPoint(x:0.0,y: 0.0)

            }
                
            
        }
        
    }
    
    //    @objc func swipeLeft(sender:UISwipeGestureRecognizer){
    //        if (self.camera?.contains(egg))!{
    //            self.camera!.position.x = (self.camera?.position.x)! + 150
    //            self.swipeSide += 1
    //        }
    //
    //    }
    //
    //    @objc func swipeRight(sender:UISwipeGestureRecognizer){
    //        if swipeSide > 0 {
    //            self.camera!.position.x = (self.camera?.position.x)! - 150
    //            swipeSide -= 1
    //        }else{
    //            swipeSide = 0
    //        }
    //
    //
    //    }
    
    @objc func swipeDown(sender:UISwipeGestureRecognizer){
        
        if (self.camera?.contains(egg))!{
            self.camera!.position.y = (self.camera?.position.y)! + 150
            self.swipeCount += 1
        }
        
    }
    
    @objc func swipeUp(sender:UISwipeGestureRecognizer){
        
        if swipeCount > 0 {
            self.camera!.position.y = (self.camera?.position.y)! - 150
            swipeCount -= 1
        }else{
            swipeCount = 0
        }
        
        
    }
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
        
        //        if egg.position.x < -(egg.size.width / 2) {
        //            egg.position =
        //                CGPoint(x: size.width - egg.size.width / 2,
        //                        y: egg.position.y)
        //
        //        }else if egg.position.x > self.size.width {
        //            egg.position = CGPoint(x: egg.size.width / 2,
        //                                          y: egg.position.y);
        //        }
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
                        self.score -= 5
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
        
        //self.camera?.position = egg.position
        
        
        
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
        
        //print("result \(self.level)")
        let transition = SKTransition.crossFade(withDuration: 1.0)
        let menuScene = MenuScene(size: size,
                                  gameResult: result,
                                  score: score,level: level)
        view?.presentScene(menuScene, transition: transition)
        
    }
}
