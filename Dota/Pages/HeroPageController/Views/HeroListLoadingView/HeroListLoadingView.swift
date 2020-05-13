//
//  HeroListLoadingView.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import UIKit

class HeroListLoadingView: BaseView {
    
    // IBOutlets
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    func show(in view: UIView) {
        activityIndicator.startAnimating()
        view.addAndManageConstraint(view: self)
    }
    
    func hide() {
        self.removeFromSuperview()
    }
}
