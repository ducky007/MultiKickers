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



class GameViewController: UIViewController, GKTurnBasedMatchmakerViewControllerDelegate {

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
    
    func joinTurnBasedMatch() {
        println("Turn Based Match")
        var mr = GKMatchRequest()
        mr.minPlayers = 2
        mr.maxPlayers = 2
        mr.defaultNumberOfPlayers = 2
        
        var tbvc = GKTurnBasedMatchmakerViewController(matchRequest: mr)
        tbvc.turnBasedMatchmakerDelegate = self
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
    
    
    // The user has cancelled
    func turnBasedMatchmakerViewControllerWasCancelled(viewController: GKTurnBasedMatchmakerViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Matchmaking has failed with an error
    func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, didFailWithError error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // A turned-based match has been found, the game should start
    func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, didFindMatch match: GKTurnBasedMatch!) {
        println("Yeah......")
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("GameScene", sender: match)
    }
    
    // Called when a users chooses to quit a match and that player has the current turn.  The developer should call playerQuitInTurnWithOutcome:nextPlayer:matchData:completionHandler: on the match passing in appropriate values.  They can also update matchOutcome for other players as appropriate.
    func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, playerQuitForMatch match: GKTurnBasedMatch!) {
        println("Quit.....")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "GameScene" {
            var gameVC = segue.destinationViewController as MyGamePlayViewController
            //gameVC.view
        }
    }
}
