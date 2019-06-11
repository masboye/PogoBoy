//
//  EggClass.swift
//  Telur
//
//  Created by boy setiawan on 08/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import Foundation
import SpriteKit

class Egg:SKSpriteNode{

    init(imageNamed: String, eggSize:CGSize) {
        
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.white, size: eggSize)
        name = "egg"
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 2)
        physicsBody?.isDynamic = false
        //box.physicsBody?.linearDamping = 1.0
        physicsBody?.mass = 0.01
        
        physicsBody?.categoryBitMask = CollisionCategoryEgg
        physicsBody?.contactTestBitMask = CollisionCategoryBatu
        //physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
