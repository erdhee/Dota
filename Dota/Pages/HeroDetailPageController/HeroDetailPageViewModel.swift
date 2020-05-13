//
//  HeroDetailPageViewModel.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RxSwift

class HeroDetailPageViewModel {
    
    // Variables
    var hero: HeroObject!
    var similarHeroes: [HeroObject]?
    
    
    init(hero: HeroObject) {
        self.hero = hero
        self.similarHeroes = HeroDataService.shared.getSimilarHero(hero: hero)
    }
    
}
