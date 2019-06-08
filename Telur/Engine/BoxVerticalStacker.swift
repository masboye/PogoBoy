//
//  BoxVerticalStacker.swift
//  Telur
//
//  Created by boy setiawan on 03/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import Foundation
import GameplayKit

struct BoxVerticalStacker{
    
    private var boxSize:CGFloat = 0.0
    private let INCREASE_LEVEL = 3
    private let ELEVATION = 13
    private var scene:SKScene!
    private var parentNode:SKSpriteNode!
    private var initialHeight:CGFloat = 0.0
    private var lastBoxHeight:CGFloat = 0.0
    
    init(boxSize: CGFloat, scene :SKScene, initialHeight: CGFloat, parent:SKSpriteNode) {
        self.boxSize = boxSize
        self.scene = scene
        self.initialHeight = initialHeight
        self.parentNode = parent
        
    }
    
    private let horizontalStacker = BoxHorizontalStacker(maximum: 5)
    
    func putBox(stackBox: (BoxColors,Int,BoxOrientationForCenterBox,BoxPosition), width:Int) -> SKSpriteNode{
        let thisBoxSize = CGSize(width: boxSize * CGFloat(width), height: boxSize )
        let box = BoxSpriteNode(imageNamed: "\(stackBox.0) box",boxSize: thisBoxSize)
        
        return box
    }
    
    mutating func stackBoxes(level:Int){
        
        let currentLevel = (level / self.INCREASE_LEVEL) + 1
        var heightOfBox = initialHeight
        
        let batuSize = CGSize(width: boxSize * CGFloat(3), height: boxSize /  2)
        let baseSideSize = CGSize(width: boxSize , height: boxSize / 2 )
        let base = FondationSpriteNode(imageNamed: "batu center",fondationSize: batuSize,fondationKananSize: baseSideSize,fondationKiriSize: baseSideSize)
        base.position = CGPoint(x: (scene.size.width / 2 )  - (base.size.width / 2) , y: initialHeight )

        parentNode.addChild(base)
        
        heightOfBox += base.size.height
        
        for _ in 1...currentLevel{


            for _ in 1...ELEVATION{

                let listOfBoxes:[(BoxColors,Int,BoxOrientationForCenterBox,BoxPosition)] = horizontalStacker.generateStack()

                var increaseOfHeight:CGFloat = 0.0

                for stackBox in listOfBoxes{
                    //print(stackBox)

                    if  listOfBoxes.count == 1 {

                        let box = putBox(stackBox: stackBox, width: 5)
                        box.position = CGPoint(x: (scene.size.width / 2 )  - (box.size.width / 2) , y: heightOfBox )

                        parentNode.addChild(box)
                        increaseOfHeight = box.size.height
                    }

                    if stackBox.1 == 4 && listOfBoxes.count == 2 {
//                         //print("\(loop) \(stackBox)")
                        if stackBox.2 == .left {

                            let box = putBox(stackBox: stackBox, width: 4)
                            box.position = CGPoint(x: (scene.size.width / 2 )  - (box.size.width / 2) - (box.size.width / 8) , y: heightOfBox )
                            parentNode.addChild(box)

                            increaseOfHeight = box.size.height

                            let nextBox = putBox(stackBox: listOfBoxes[1], width: listOfBoxes[1].1)
                            nextBox.position = CGPoint(x: box.position.x + box.size.width , y: heightOfBox )
                            parentNode.addChild(nextBox)


                        }

                        if stackBox.2 == .right {

                            let box = putBox(stackBox: stackBox, width: 4)
                            box.position = CGPoint(x: (scene.size.width / 2 )  - (box.size.width / 2) + (box.size.width / 8) , y: heightOfBox )
                            parentNode.addChild(box)

                            increaseOfHeight = box.size.height

                            let nextBox = putBox(stackBox: listOfBoxes[1], width: listOfBoxes[1].1)
                            nextBox.position = CGPoint(x: box.position.x - nextBox.size.width , y: heightOfBox )
                            parentNode.addChild(nextBox)


                        }

                    }

                    if stackBox.1 == 3 && listOfBoxes.count == 2 {
                        ////print("\(loop) \(stackBox)")
                        if stackBox.2 == .left {

                            let box = putBox(stackBox: stackBox, width: 3)
                            box.position = CGPoint(x: (scene.size.width / 2 )  - (box.size.width / 2) , y: heightOfBox )
                            parentNode.addChild(box)

                            increaseOfHeight = box.size.height

                            let nextBox = putBox(stackBox: listOfBoxes[1], width: listOfBoxes[1].1)
                            nextBox.position = CGPoint(x: box.position.x + box.size.width , y: heightOfBox )
                            parentNode.addChild(nextBox)

                        }

                        if stackBox.2 == .right {

                            let box = putBox(stackBox: stackBox, width: 3)
                            box.position = CGPoint(x: (scene.size.width / 2 )  - (box.size.width / 2)  , y: heightOfBox )
                            parentNode.addChild(box)

                            increaseOfHeight = box.size.height

                            let nextBox = putBox(stackBox: listOfBoxes[1], width: listOfBoxes[1].1)
                            nextBox.position =  CGPoint(x: box.position.x - nextBox.size.width , y: heightOfBox )
                            parentNode.addChild(nextBox)

                        }

                    }

                    if stackBox.1 == 2 && listOfBoxes.count == 3 && stackBox.3 != .center {
                       //print("\(loop) \(stackBox.1) \(stackBox.3)")
                        if stackBox.2 == .left {

                            let box = putBox(stackBox: stackBox, width: 2)
                            box.position = CGPoint(x: (scene.size.width / 2 )  - (box.size.width / 2) , y: heightOfBox )
                            parentNode.addChild(box)

                            increaseOfHeight = box.size.height

                            let nextBox = putBox(stackBox: listOfBoxes[1], width: listOfBoxes[1].1)
                            nextBox.position =  CGPoint(x: box.position.x + box.size.width , y: heightOfBox )
                            parentNode.addChild(nextBox)


                        }

                        if stackBox.2 == .right {

                            let box = putBox(stackBox: stackBox, width: 2)
                            box.position = CGPoint(x: (scene.size.width / 2 )  - (box.size.width / 2) , y: heightOfBox )
                            parentNode.addChild(box)

                            increaseOfHeight = box.size.height

                            let nextBox = putBox(stackBox: listOfBoxes[2], width: listOfBoxes[2].1)
                            nextBox.position =  CGPoint(x: box.position.x - nextBox.size.width , y: heightOfBox )
                            parentNode.addChild(nextBox)


                        }


                    }

                    if stackBox.3 == .center && stackBox.2 == .center {
                       // print("\(loop) \(stackBox)")

                        let box = putBox(stackBox: stackBox, width: 1)
                        box.position = CGPoint(x: (scene.size.width / 2 )  - (box.size.width / 2) , y: heightOfBox )
                        parentNode.addChild(box)

                        increaseOfHeight = box.size.height

                        var nextBox = putBox(stackBox: listOfBoxes[1], width: listOfBoxes[1].1)
                        nextBox.position =  CGPoint(x: box.position.x + box.size.width , y: heightOfBox )
                        parentNode.addChild(nextBox)

                        nextBox = putBox(stackBox: listOfBoxes[2], width: listOfBoxes[2].1)
                        nextBox.position =   CGPoint(x: box.position.x - nextBox.size.width , y: heightOfBox )
                        parentNode.addChild(nextBox)

                    }


                }
                //print(heightOfBox)
                heightOfBox += increaseOfHeight

            }

        }
        
        lastBoxHeight = heightOfBox

    }
    
    func placeEgg(level:Int){
        
        let eggSize = CGSize(width: boxSize, height: boxSize)
        let egg = Egg(imageNamed: "egg",eggSize: eggSize)
        egg.position = CGPoint(x: (scene.size.width / 2 ), y: lastBoxHeight + egg.size.height )
        parentNode.addChild(egg)
        
    }

    
    
}
