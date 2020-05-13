//
//  HeroCollectionCellViewData.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation

class HeroCollectionCellViewData {
    var imageUrl: URL?
    var heroName: String?
    var heroRole: String?
    var heroAttribute: HeroAttributeType?
    var heroObject: HeroObject?
    
    init(hero: HeroObject) {
        heroObject = hero
        imageUrl = hero.getImageUrl()
        heroName = hero.localizedName ?? ""
        heroRole = hero.roles.map({ $0.name ?? "" }).joined(separator: ", ")
        heroAttribute = hero.getAttributeType()
    }
}
