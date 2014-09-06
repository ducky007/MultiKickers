//
//  GameScene.swift
//  multikickers
//
//  Created by Changyong Chen on 14-8-25.
//  Copyright (c) 2014年 A21.com. All rights reserved.
//

import SpriteKit
import GameKit

class GameScene: SKScene {
    
    var ship:SKSpriteNode!
    var myMatch:GKTurnBasedMatch!
    var nextParticipant = [GKTurnBasedParticipant]()
    
    override func didMoveToView(view: SKView) {
        println("I am in ..........")
        self.loadAndDisplayMatchData()
        ship = SKSpriteNode(imageNamed: "Spaceship")
        addChild(ship)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var endPoint:CGPoint = touch.locationInNode(self)
        ship.position.x = endPoint.x
        ship.position.y = endPoint.y
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    func loadAndDisplayMatchData() {
        println("load data")
        self.myMatch.loadMatchDataWithCompletionHandler { (matchData:NSData!, matchError:NSError!) -> Void in
            var nextParticipant:GKTurnBasedParticipant!
            if (matchData != nil) {
                println("MD: \(matchData)")
                println("participants: \(self.myMatch.participants.count)")
                println("current participant: \(self.myMatch.currentParticipant.player)")
                for participant in self.myMatch.participants {
                    println("list par: \(participant.description)")
                    if participant.playerID == self.myMatch.currentParticipant {
                        break
                    }
                    nextParticipant = participant as GKTurnBasedParticipant
                }
            }
            
            if matchData.length > 0 {
                println("some data matchID: \(self.myMatch.matchID)")
            } else {
                println("no data yet matchID: \(self.myMatch.matchID)")
            }
        }
    }
    
    func sendTurn() {
        var message:NSString = "======= hello friend ======="
        
        var updatedMatchData:NSData = message.dataUsingEncoding(NSUTF8StringEncoding)!
        
        self.myMatch.endTurnWithNextParticipants([nextParticipant], turnTimeout:1000.0, matchData:updatedMatchData, completionHandler: { (matchError:NSError!) -> Void in
            println("error:\(matchError)")
        })
    }

}
