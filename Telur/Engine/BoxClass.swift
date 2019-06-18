//
//  BoxClass.swift
//  Telur
//
//  Created by boy setiawan on 08/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import Foundation
import SpriteKit

class BoxSpriteNode : SKSpriteNode
{
    
    
    var ballStartX: CGFloat = 0.0
    var ballStartY: CGFloat = 0.0
    
    var isSelected = false
    //var canMove = true
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //print("\(isSelected)")
        //if !isSelected{
            if let touch = touches.first {
                physicsBody?.isDynamic = true
                let location = touch.location(in: self.parent!)
                ballStartX =  (position.x) - location.x // Location X of your sprite when touch started
                ballStartY =  (position.y) - location.y // Location Y of your sprite when touch started
                //print("\(ballStartX)-\(ballStartY)")
                isSelected = !isSelected
                //canMove = !canMove
                
                Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.putBoxDown(_:)), userInfo: nil, repeats: false)
            }
        //}
    }
    
    @objc func putBoxDown(_ timer:Timer){
        physicsBody?.isDynamic = true
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        physicsBody?.isDynamic = false
        
            if let touch = touches.first {
                
                let location = touch.location(in: self.parent!)
                
                let newLocation =  CGPoint(x: location.x+ballStartX, y: location.y+ballStartY) // Move node around with distance to your finger
                position = newLocation
                //self.isSelected = true
                //print("move")
            }
        
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touch ended")
        backToNormal()
       
        
    }
    
    func backToNormal(){
        if !isSelected{
           
            physicsBody?.isDynamic = true
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touch cancelled")
        backToNormal()
        
        
    }
    
    
    init(imageNamed: String, boxSize:CGSize) {
        
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.white, size: boxSize)
        name = "\(imageNamed)"
        
        anchorPoint = CGPoint(x: 0, y: 0)
        
        isUserInteractionEnabled = false
        physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x:size.width / 2, y: size.height / 2))
        
        physicsBody?.isDynamic = true
        
        //box.physicsBody?.linearDamping = 1.0
        //physicsBody?.mass = 0.01
        
        physicsBody?.categoryBitMask = CollisionCategoryBox
        physicsBody?.contactTestBitMask = CollisionCategoryBox
        //physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
