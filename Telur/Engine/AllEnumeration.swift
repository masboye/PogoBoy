//
//  BoxColors.swift
//  Telur
//
//  Created by boy setiawan on 02/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import Foundation

enum BoxColors: String {
    case white = "white"
    case red = "red"
    case black = "black"
    case blue = "blue"
    case amber = "amber"
    case gray = "gray"
    case green = "green"
    case purple = "purple"
    case yellow = "yellow"
}
enum BoxPosition: Character {
    case fixed = "F"
    case right = "R"
    case left = "L"
    case empty = "E"
    case center = "C"
    
}

enum BoxOrientation: Int {
    case left = 0
    case right = 1
    
}

enum BoxOrientationForCenterBox: Int {
    case left = 0
    case right = 1
    case center = 2
    
}
