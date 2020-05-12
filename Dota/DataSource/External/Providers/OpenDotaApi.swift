//
//  OpenDotaApi.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import Moya

enum OpenDotaApi {
    case getAllHeroes
}

extension OpenDotaApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.opendota.com/api/")! // swiftlint:disable:this force_unwrapping
    }
    
    var path: String {
        switch self {
        case .getAllHeroes:
            return "herostats/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllHeroes:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllHeroes:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
