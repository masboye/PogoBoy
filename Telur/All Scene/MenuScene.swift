//
//  MenuScene.swift
//  Telur
//
//  Created by boy setiawan on 12/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var level = 1
    var result = false
    var score = 0
    
    init(size: CGSize, gameResult: Bool, score:Int, level:Int) {
        
        super.init(size: size)
        
        self.result = gameResult
        self.score = score
        self.level = level
        
        let backgroundNode = SKSpriteNode(imageNamed: "second")
        // adding the second background
        backgroundNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        //secondBackgroundNode.alpha = 1
        backgroundNode.zPosition = -1
        addChild(backgroundNode)
        
        let gameResultTextNode = SKLabelNode(fontNamed: "Copperplate")
        gameResultTextNode.text = "YOU " + (gameResult ? "WON" : "LOST") + " Level \(self.level)"
        gameResultTextNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        gameResultTextNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        gameResultTextNode.fontSize = 20
        gameResultTextNode.fontColor = SKColor.red
        gameResultTextNode.position = CGPoint(x: size.width / 2.0, y: size.height - 200.0)
        addChild(gameResultTextNode)
        
        let scoreTextNode = SKLabelNode(fontNamed: "Copperplate")
        scoreTextNode.text = "SCORE :  \(self.score)"
        scoreTextNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreTextNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        scoreTextNode.fontSize = 20
        scoreTextNode.fontColor = SKColor.red
        scoreTextNode.position = CGPoint(x: size.width / 2.0,
                                         y: gameResultTextNode.position.y - 40.0)
        addChild(scoreTextNode)
        
        let tryAgainTextNodeLine1 = SKLabelNode(fontNamed: "Copperplate")
        tryAgainTextNodeLine1.text = "TAP ANYWHERE"
        tryAgainTextNodeLine1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        tryAgainTextNodeLine1.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        tryAgainTextNodeLine1.fontSize = 20
        tryAgainTextNodeLine1.fontColor = SKColor.red
        tryAgainTextNodeLine1.position = CGPoint(x: size.width / 2.0, y: 100.0)
        addChild(tryAgainTextNodeLine1)
        
        let tryAgainTextNodeLine2 = SKLabelNode(fontNamed: "Copperplate")
        tryAgainTextNodeLine2.text = "TO PLAY AGAIN!"
        tryAgainTextNodeLine2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        tryAgainTextNodeLine2.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        tryAgainTextNodeLine2.fontSize = 20
        tryAgainTextNodeLine2.fontColor = SKColor.red
        tryAgainTextNodeLine2.position = CGPoint(x: size.width / 2.0,
                                                 y: tryAgainTextNodeLine1.position.y - 40.0)
        addChild(tryAgainTextNodeLine2)
        
       // print("init \(self.level)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nextLevel:Int = result ? level + 1 : level
        print("\(nextLevel)")
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
        scene?.scaleMode = .aspectFill
        let gameScene = GameScene(size: size,level: nextLevel,score: score)
        view?.presentScene(gameScene, transition: transition)
    }
    
}
