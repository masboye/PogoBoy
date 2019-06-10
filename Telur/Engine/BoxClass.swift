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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Touched \(self.name) \(self.parent?.children.count)")
        
        self.removeFromParent()
    }
    
    init(imageNamed: String, boxSize:CGSize) {
        
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.white, size: boxSize)
        name = "\(imageNamed) box"
        anchorPoint = CGPoint(x: 0, y: 0)
        
        isUserInteractionEnabled = true
        
        
        
        physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x:size.width / 2, y: size.height / 2))
        
        physicsBody?.isDynamic = false
        
        //box.physicsBody?.linearDamping = 1.0
        //physicsBody?.mass = 0.01
        
        //physicsBody?.categoryBitMask = CollisionCategoryEgg
        //physicsBody?.contactTestBitMask = CollisionCategoryBatu
        //physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
