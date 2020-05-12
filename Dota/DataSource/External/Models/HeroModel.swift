//
//  HeroModel.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation

struct HeroModel: Codable {
    var id: Int
    var name: String
    var localizedName: String
    var primaryAttr: String
    var attackType: String
    var roles: [String]
    var img: String
    var baseAttackMin: Double
    var baseAttackMax: Double
    var baseHealth: Double
    var baseArmor: Double
    var baseMana: Double
    var moveSpeed: Double
    
}
