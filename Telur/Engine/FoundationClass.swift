//
//  FoundationClass.swift
//  Telur
//
//  Created by boy setiawan on 08/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import Foundation
import SpriteKit

class FondationSpriteNode : SKSpriteNode
{
    init(imageNamed: String, fondationSize:CGSize, fondationKananSize:CGSize, fondationKiriSize:CGSize) {
        
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.white, size: fondationSize)
        name = "batu"
        
        anchorPoint = CGPoint(x: 0, y: 0)
        //base.size = CGSize(width: boxSize * CGFloat(3), height: boxSize /  2)
        //position = CGPoint(x: (scene.size.width / 2 )  - (base.size.width / 2) , y: initialHeight )
        //parentNode.addChild(base)
        
        let baseKanan = SKSpriteNode(imageNamed: "batu kanan")
        baseKanan.size = fondationKananSize
        addChild(baseKanan)
        baseKanan.position = CGPoint(x: position.x + size.width + baseKanan.size.width / 2 , y: baseKanan.size.height / 2 )
        
        let baseKiri = SKSpriteNode(imageNamed: "batu kiri")
        baseKiri.size = fondationKiriSize
        addChild(baseKiri)
        baseKiri.position = CGPoint(x: 0 - baseKiri.size.width / 2  , y: baseKiri.size.height / 2 )
//        //print("\(base.size) \(baseKanan.size)")
//
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width + (baseKanan.size.width / 1.2), height: size.height), center: CGPoint(x:size.width / 2, y: size.height / 2))
//
        
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = CollisionCategoryBatu
        //physicsBody?.contactTestBitMask = CollisionCategoryBatu
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
