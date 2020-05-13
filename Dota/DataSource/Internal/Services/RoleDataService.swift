//
//  RoleDataService.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RealmSwift

class RoleDataService {
    public static let shared: RoleDataService = RoleDataService()
    private let realm: Realm = try! Realm()
    
    /**
     * Get list of available role
     * @return:
     * - [RoleObject]
     */
    
    public func get() -> [RoleObject] {
        return realm.objects(RoleObject.self)
            .map({ $0 })
    }
}
