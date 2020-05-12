//
//  RoleObject.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RealmSwift

class RoleObject: Object {
    @objc dynamic var name: String?
    let heroes = LinkingObjects(fromType: HeroObject.self, property: "roles")
    
    convenience init(name: String) {
        self.init()
        
        self.name = name
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
