//
//  ObstacleService.swift
//  CircleGame
//
//  Created by Rus Razvan on 28/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import UIKit

class ObstacleService {
    private init() {}
    static let shared = ObstacleService()
    
    var distanceBetween: CGFloat = 400
    
    let minXPosition: CGFloat = 300
    let maxXPosition: CGFloat = 500
    let minYPosition: CGFloat = 50
    let maxYPosition: CGFloat = -50
    
    let outOfScreenPosition: CGFloat = -750
    
    func resetDistance() {
        self.distanceBetween = 400
    }
}
