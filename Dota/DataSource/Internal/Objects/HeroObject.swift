//
//  HeroObject.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RealmSwift

class HeroObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var localizedName: String?
    @objc dynamic var primaryAttr: String?
    @objc dynamic var attackType: String?
    @objc dynamic var img: String?
    @objc dynamic var baseAttackMin: Double = 0.0
    @objc dynamic var baseAttackMax: Double = 0.0
    @objc dynamic var baseHealth: Double = 0.0
    @objc dynamic var baseArmor: Double = 0.0
    @objc dynamic var baseMana: Double = 0.0
    @objc dynamic var moveSpeed: Double = 0.0
    let roles = List<RoleObject>()
    
    convenience init(model: HeroModel) {
        self.init()
        
        id = model.id
        name = model.name
        localizedName = model.localizedName
        primaryAttr = model.primaryAttr
        attackType = model.attackType
        img = model.img
        baseAttackMin = model.baseAttackMin
        baseAttackMax = model.baseAttackMax
        baseHealth = model.baseHealth
        baseArmor = model.baseArmor
        baseMana = model.baseMana
        moveSpeed = model.moveSpeed
        
        for role in model.roles {
            roles.append(RoleObject(name: role))
        }
    }
    
    func getAttributeType() -> HeroAttributeType? {
        return HeroAttributeType(rawValue: primaryAttr ?? "");
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
