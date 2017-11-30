//
//  CircleService.swift
//  CircleGame
//
//  Created by Rus Razvan on 28/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import UIKit

class CircleService {
    private init() {}
    static let shared = CircleService()
    
    let initialSize: CGFloat = 50
    let minSize: CGFloat = 52
    
    let initialScale: CGFloat = 1
    let maxScale: CGFloat = 10
    let scaleDuration: TimeInterval = 5
    let scaleMovementX: CGFloat = 220
    let scaleMovementY: CGFloat = 0
    
    let scaleFailedDuration: TimeInterval = 0.1
    
    let animationAngleRotation: CGFloat = -30
    let moveAnimationDuration: TimeInterval = 3
    let moveBackAnimationDuration: TimeInterval = 2

    let startingPoint: CGFloat = -450
    let endingPoint: CGFloat = 650
}
