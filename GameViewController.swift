//
//  GameViewController.swift
//  multikickers
//
//  Created by Changyong Chen on 14-8-25.
//  Copyright (c) 2014年 A21.com. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit



class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.authenticateLocalPlayer()
    }
    
    func authenticateLocalPlayer() {
        var localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController:UIViewController!, error:NSError!) -> Void in
            if((viewController) != nil) {
                self.presentViewController(viewController, animated: true, completion: nil)
            } else if (localPlayer.authenticated){
                println("Local player already authenticated")
                self.showMatchMaker()
            } else {
                println("Local player could not be authenticated, disabling GameCenter")
            }
        }
        
        
    }

    func showMatchMaker() {
        println("match making ......")
        var matchRequest = GKMatchRequest()
        matchRequest.minPlayers = 2
        matchRequest.maxPlayers = 2
        matchRequest.defaultNumberOfPlayers = 2
        
        var mmvc: GKMatchmakerViewController = GKMatchmakerViewController(matchRequest: matchRequest)
        self.presentViewController(mmvc, animated: true, completion: nil)
    }
}
