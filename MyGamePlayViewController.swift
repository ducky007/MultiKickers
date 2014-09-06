//
//  MyGamePlayViewController.swift
//  multikickers
//
//  Created by Changyong Chen on 14-8-30.
//  Copyright (c) 2014年 A21.com. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class MyGamePlayViewController: UIViewController {
    
    var currentMatch:GKTurnBasedMatch!
    var nextParticipant = [GKTurnBasedParticipant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("my game play")
    
        self.loadAndDisplayMatchData()
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            skView.showsPhysics = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    func loadAndDisplayMatchData() {
        println("load data")
        self.currentMatch.loadMatchDataWithCompletionHandler { (matchData:NSData!, matchError:NSError!) -> Void in
            var nextParticipant:GKTurnBasedParticipant!
            if (matchData != nil) {
                println("MD: \(matchData)")
                println("participants: \(self.currentMatch.participants.count)")
                println("current participant: \(self.currentMatch.currentParticipant.player)")
                for participant in self.currentMatch.participants {
                    println("list par: \(participant.description)")
                    if participant.playerID == self.currentMatch.currentParticipant {
                        break
                    }
                    nextParticipant = participant as GKTurnBasedParticipant
                }
            }
            
            if matchData.length > 0 {
                println("some data matchID: \(self.currentMatch.matchID)")
            } else {
                println("no data yet matchID: \(self.currentMatch.matchID)")
            }
        }
    }
    
    func sendData() {
        var message:NSString = "======= hello friend ======="
        
        var updatedMatchData:NSData = message.dataUsingEncoding(NSUTF8StringEncoding)!
        
        self.currentMatch.endTurnWithNextParticipants([nextParticipant], turnTimeout:1000.0, matchData:updatedMatchData, completionHandler: { (matchError:NSError!) -> Void in
            println("error:\(matchError)")
        })
    }
}