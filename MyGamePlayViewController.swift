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



class MyGamePlayViewController: UIViewController {
    
    var tbMatch:GKTurnBasedMatch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("my game play")
        self.loadAndDisplayMatchData()
    }
    
    func loadAndDisplayMatchData() {
        println("load data")
        self.tbMatch.loadMatchDataWithCompletionHandler { (matchData:NSData!, matchError:NSError!) -> Void in
            if (matchData != nil) {
                println("MD: \(matchData)")
            }
            
            if matchData.length > 0 {
                println("some data matchID: \(self.tbMatch.matchID)")
            } else {
                println("no data yet matchID: \(self.tbMatch.matchID)")
            }
        }
    }
}