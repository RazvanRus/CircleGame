//
//  ZPositionService.swift
//  CircleGame
//
//  Created by Rus Razvan on 02/12/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import UIKit

class ZPositionService {
    private init() {}
    static let shared = ZPositionService()
    
    let background: CGFloat = 0
    let circle: CGFloat = 1
    let obstacle: CGFloat = 1
    let ground: CGFloat = 2
    let labels: CGFloat = 3
    let score: CGFloat = 3
    let endGame: CGFloat = 4
}
