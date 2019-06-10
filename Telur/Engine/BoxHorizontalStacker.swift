//
//  BoxStacker.swift
//  Telur
//
//  Created by boy setiawan on 02/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import Foundation

struct BoxHorizontalStacker {
    
    private var maximumNumberOfBox = 0
    init(maximum : Int) {
        self.maximumNumberOfBox = maximum
    }
    
    private let boxEngine = BoxEngine()
    
    func generateStack() -> [(Int,BoxColors,Int,BoxOrientationForCenterBox)] {
        
        var boxes:[(Int,BoxColors,Int,BoxOrientationForCenterBox)] = []
        let centerColor = generateCenterBox()
        ////print(center)
        
        let centerBoxSize = produceBoxSizeNormal()
        ////print(centerBoxSize)
        
        
        
        switch centerBoxSize {
        case 5:
            //print("5 Boxes")
            let boxOrientationCenter = BoxOrientationForCenterBox.center
            boxes.append((5,centerColor,centerBoxSize,boxOrientationCenter))
            return boxes
            
        case 4:
            let orientation = BoxOrientation(rawValue: whichSide2Options())!
            //print("4 \(String(describing: orientation))")
            
            
            switch orientation {
            case .left :
                let rightBox = boxEngine.generateBox()
                let rightBoxSize = produceBoxSizeReduced()
                //print("LEFT --> Right Box \(rightBox) \(rightBoxSize)")
                boxes.append((4,centerColor,centerBoxSize,BoxOrientationForCenterBox.left))
                boxes.append((4,rightBox,rightBoxSize,BoxOrientationForCenterBox.right))
                
            case .right:
                let leftBox = boxEngine.generateBox()
                let leftBoxSize = produceBoxSizeReduced()
                //print("RIGHT --> Left Box \(leftBox) \(leftBoxSize)")
                boxes.append((4,centerColor,centerBoxSize,BoxOrientationForCenterBox.right))
                boxes.append((4,leftBox,leftBoxSize,BoxOrientationForCenterBox.left))
            }
            
            return boxes
            
        case 3:
            let orientation = BoxOrientationForCenterBox(rawValue: whichSide3Options())!
            //print("3 \(String(describing: orientation))")
            
            switch orientation {
            case .left:
                let rightBox = boxEngine.generateBox()
                let rightBoxSize = produceBoxSizeReduced()
                //print("LEFT --> Right Box \(rightBox) \(rightBoxSize)")
                boxes.append((3,centerColor,centerBoxSize,BoxOrientationForCenterBox.left))
                boxes.append((3,rightBox,rightBoxSize,BoxOrientationForCenterBox.right))
            case .right:
                let leftBox = boxEngine.generateBox()
                let leftBoxSize = produceBoxSizeReduced()
                //print("RIGHT --> Left Box \(leftBox) \(leftBoxSize)")
                boxes.append((3,centerColor,centerBoxSize,BoxOrientationForCenterBox.right))
                boxes.append((3,leftBox,leftBoxSize,BoxOrientationForCenterBox.left))
            default:
                //print("3 in center")
                boxes.append((3,centerColor,centerBoxSize,BoxOrientationForCenterBox.center))
                //for right
                let rightBox = boxEngine.generateBox()
                let rightBoxSize = produceBoxSizeReduced()
                //print("CENTER --> Right Box \(rightBox) \(rightBoxSize)")
                boxes.append((3,rightBox,rightBoxSize,BoxOrientationForCenterBox.right))
                //for left
                let leftBox = boxEngine.generateBox()
                let leftBoxSize = produceBoxSizeReduced()
                //print("CENTER --> Left Box \(leftBox) \(leftBoxSize)")
                boxes.append((3,leftBox,leftBoxSize,BoxOrientationForCenterBox.left))
                
            }
            
            return boxes
        case 2:
            let orientation = BoxOrientation(rawValue: whichSide2Options())!
            //print("2 \(String(describing: orientation))")
            
            switch orientation {
            case .left :
                //print("2 in \(orientation)")
                boxes.append((2,centerColor,centerBoxSize,BoxOrientationForCenterBox.left))
                //for right
                let rightBox = boxEngine.generateBox()
                let rightBoxSize = produceBoxSizeMedium()
                //print("LEFT --> Right Box \(rightBox) \(rightBoxSize)")
                boxes.append((2,rightBox,rightBoxSize,BoxOrientationForCenterBox.right))
                //for left
                let leftBox = boxEngine.generateBox()
                let leftBoxSize = produceBoxSizeMedium()
                //print("LEFT --> Left Box \(leftBox) \(leftBoxSize)")
                boxes.append((2,leftBox,leftBoxSize,BoxOrientationForCenterBox.left))
                
            case .right:
                //print("2 in \(orientation)")
                boxes.append((2,centerColor,centerBoxSize,BoxOrientationForCenterBox.right))
                //for right
                let rightBox = boxEngine.generateBox()
                let rightBoxSize = produceBoxSizeMedium()
                //print("RIGHT --> Right Box \(rightBox) \(rightBoxSize)")
                boxes.append((2,rightBox,rightBoxSize,BoxOrientationForCenterBox.right))
                //for left
                let leftBox = boxEngine.generateBox()
                let leftBoxSize = produceBoxSizeMedium()
                //print("LEFT --> Left Box \(leftBox) \(leftBoxSize)")
                boxes.append((2,leftBox,leftBoxSize,BoxOrientationForCenterBox.left))
            }
            return boxes
            
        default:
            //print("1 Box")
            boxes.append((1,centerColor,1,BoxOrientationForCenterBox.center))
            let rightBox = boxEngine.generateBox()
            let rightBoxSize = produceBoxSizeSide()
            //print("RIGHT --> Right Box \(rightBox) \(rightBoxSize)")
            boxes.append((1,rightBox,rightBoxSize,BoxOrientationForCenterBox.right))
            //for left
            let leftBox = boxEngine.generateBox()
            let leftBoxSize = produceBoxSizeSide()
            //print("LEFT --> Left Box \(leftBox) \(leftBoxSize)")
            boxes.append((1,leftBox,leftBoxSize,BoxOrientationForCenterBox.left))
        }
        
        return boxes
        
    }
    
    
    private func generateCenterBox()-> BoxColors{
        return boxEngine.generateBox()
    }
    private func whichSide2Options() -> Int{
        return Int.random(in: 0...1)
    }
    private func whichSide3Options() -> Int{
        return Int.random(in: 0...2)
    }
    private  func produceBoxSizeNormal() -> Int{
        if whichSide() == 0 {
            
            return 0
        }
        //return 1
        return Int.random(in: 1...5)
    }
    
    private func produceBoxSizeReduced() -> Int{
        if whichSide() == 0 {
            
            return 0
        }
        
        return Int.random(in: 1...2)
    }
    
    private func produceBoxSizeMedium() -> Int{
        if whichSide() == 0 {
            
            return 0
        }
        
        return Int.random(in: 1...2)
    }
    
    private func produceBoxSizeSide() -> Int{
        
        return Int.random(in: 1...3)
    }
    
    //random to produce empty box
    private func whichSide() -> Int{
        return Int.random(in: 0...7)
    }
    
}


