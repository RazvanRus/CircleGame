//
//  IphoneTypeService.swift
//  CircleGame
//
//  Created by Rus Razvan on 27/11/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import UIKit

class IphoneTypeService {
    private init() {}
    static var shared = IphoneTypeService()
    
    func isIphoneX() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436 {
                return true
            }
        }
        return false
    }
}
