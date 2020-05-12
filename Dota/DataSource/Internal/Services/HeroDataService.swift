//
//  HeroDataService.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RealmSwift

class HeroDataService {
    public static let shared: HeroDataService = HeroDataService()
    private let realm: Realm = try! Realm()
    
    /**
     * Add list of heroes from API
     * @param:
     * - heroes: [HeroModel] @required
     *
     * @return:
     * - [HeroObject]
     */
    
    public func add(heroes: [HeroModel]) -> [HeroObject] {
        let heroObjects: [HeroObject] = heroes.map { (hero) -> HeroObject in
            return HeroObject(model: hero)
        }
        
        for hero in heroObjects {
            try! realm.write {
                realm.add(hero, update: .modified)
            }
        }
        
        return heroObjects
    }
    
    /**
     * Get list of heroes
     * @param:
     * - role: RoleObject (optional)
     *
     * @return:
     * - [HeroObject]
     */
    
    public func get(role: RoleObject?) -> [HeroObject] {
        guard let role = role else {
            return realm.objects(HeroObject.self).map { $0 }
        }
        
        return role.heroes.map { (hero) -> HeroObject in
            return hero
        }
    }
    
    /**
     * Get Similar Heroes by given Attributes
     * @param:
     * - attribute: HeroAttributeType (Required)
     *
     * @return:
     * - [HeroObject]
     */
    
    public func getSimilarHero(attribute: HeroAttributeType) -> [HeroObject] {
        return realm.objects(HeroObject.self).filter { (hero) -> Bool in
            guard let type = hero.getAttributeType() else { return false }
            return type == attribute
        }
        .sorted { (firstHero, secondHero) -> Bool in
            switch (attribute) {
            case .agi:
                return firstHero.moveSpeed > secondHero.moveSpeed
            case .str:
                return firstHero.baseAttackMax > secondHero.baseAttackMax
            case .int:
                return firstHero.baseMana > secondHero.baseMana
            }
        }
        .prefix(3)
        .map({$0})
    }
}
