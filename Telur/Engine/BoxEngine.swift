//
//  BoxEngine.swift
//  Telur
//
//  Created by boy setiawan on 02/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import Foundation


struct BoxEngine{
    
    private func produceColor() -> Int{
        //return 2
        return Int.random(in: 1...9)
    }
    
    private func produceBoxColor() -> BoxColors{
        
        let color = produceColor()
        
        switch color {
        case 1:
            return (BoxColors(rawValue: "white") ?? nil)!
        case 2:
            return (BoxColors(rawValue: "red") ?? nil)!
        case 3:
            return (BoxColors(rawValue: "black") ?? nil)!
        case 4:
            return (BoxColors(rawValue: "blue") ?? nil)!
        case 5:
            return (BoxColors(rawValue: "amber") ?? nil)!
        case 6:
            return (BoxColors(rawValue: "gray") ?? nil)!
        case 7:
            return (BoxColors(rawValue: "green") ?? nil)!
        case 8:
            return (BoxColors(rawValue: "purple") ?? nil)!
            
        default:
            return (BoxColors(rawValue: "yellow") ?? nil)!
        }
    }
    
    func generateBox() -> BoxColors{
        return produceBoxColor()
    }
    
    
}
