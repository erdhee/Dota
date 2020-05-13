//
//  RoleDataService.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

class RoleDataService {
    public static let shared: RoleDataService = RoleDataService()
    private let realm: Realm = try! Realm()
    
    /**
     * Get list of available role
     * @return:
     * - [RoleObject]
     */
    
    public func get() -> Observable<[RoleObject]> {
        let roles = realm.objects(RoleObject.self)
        return Observable.collection(from: roles)
            .map{( $0.map({ $0 }) )}
    }
}
