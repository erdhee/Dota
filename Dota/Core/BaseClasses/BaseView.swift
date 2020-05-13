//
//  BaseView.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    // Mark: Initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubview()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSubview()
    }
    
    deinit {
        debugPrint("\(self.className()) deallocated")
    }
    
    // Mark: Load View
    
    open func loadView() {
        
    }
    
    // Mark: Setup Subview
    
    private func setupSubview() {
        let bundle: Bundle = Bundle(for: type(of: self))
        let view: UIView = bundle.loadNibNamed(self.className(), owner: self, options: nil)?.first as! UIView
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = self.backgroundColor
        self.insertSubview(view, at: 0)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["view": view]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["view": view]))
        
        self.loadView()
    }
}
