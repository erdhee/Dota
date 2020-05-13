//
//  HeroDataService.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

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
    
    public func get(role: RoleObject?) -> Observable<[HeroObject]> {
        let heroes = realm.objects(HeroObject.self)
        
        if let role = role {
            return Observable.of(role.heroes).map({ $0.map({ $0 }) })
        } else {
            return Observable.collection(from: heroes)
                .map({ $0.map({ $0}) })
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
    
    public func getSimilarHero(hero: HeroObject) -> [HeroObject] {
        guard let heroType = hero.getAttributeType() else { return [] }
        
        return realm.objects(HeroObject.self).filter { (_hero) -> Bool in
            guard let type = _hero.getAttributeType() else { return false }
            return type == heroType && _hero.name != hero.name
        }
        .sorted { (firstHero, secondHero) -> Bool in
            switch (heroType) {
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
