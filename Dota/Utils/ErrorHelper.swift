//
//  ErrorHelper.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation

class ErrorHelper {
    public static var shared: ErrorHelper = ErrorHelper()
    
    func getMessage(error: Error) -> String {
        let errorCode: Int = (error as NSError).code
        
        if (errorCode == NSURLErrorNotConnectedToInternet) {
            return "Looks like there's a connection issue. Please check your connection."
        } else if (errorCode == NSURLErrorNetworkConnectionLost || errorCode == NSURLErrorTimedOut) {
            return "Looks like your connection is unstable. Please check your connection."
        }
        
        return "Something went wrong. Please try again later."
    }
}
