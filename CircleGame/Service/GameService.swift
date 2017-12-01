//
//  GameService.swift
//  CircleGame
//
//  Created by Rus Razvan on 01/12/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import Foundation

class GameService {
    private init() {}
    static let shared = GameService()
    
    func set(highscore points: Int) {
        UserDefaults.standard.set(points, forKey: "RusRazvan.CircleGame.highscore")
        UserDefaults.standard.synchronize()
    }
    
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: "RusRazvan.CircleGame.highscore")
    }
}
