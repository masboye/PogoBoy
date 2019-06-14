//
//  GameViewController.swift
//  Telur
//
//  Created by boy setiawan on 02/06/19.
//  Copyright © 2019 boy setiawan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            
            let gameScene = GameScene(size: self.view.frame.size ,level: 0,score: 0)
            gameScene.scaleMode = .aspectFill
            view.presentScene(gameScene, transition: transition)
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
            
            //show physic body
            //view.showsPhysics = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
