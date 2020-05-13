//
//  NSObjectExtension.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation

public extension NSObject {
    
    func className() -> String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }
    
    static func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
}
