//
//  MenuVC.swift
//  MyFirstGame
//
//  Created by Kobi Lev on 13/11/2018.
//  Copyright © 2018 Kobi Lev. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

enum gameType{
    case Easy
    case Medium
    case Hard
    case player2
}

class MenuVC : UIViewController {
    
    @IBAction func Players(_ sender: UIButton) {
        moveToGame(game: .player2)
    }
    
    
    @IBAction func Easy(_ sender: UIButton) {
        moveToGame(game: .Easy)
    }
    
    
    @IBAction func Medium(_ sender: UIButton) {
        moveToGame(game: .Medium)
    }
    
    @IBAction func Hard(_ sender: UIButton) {
        moveToGame(game: .Hard)
    }
    
    
    func moveToGame(game : gameType)
    {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    
}
