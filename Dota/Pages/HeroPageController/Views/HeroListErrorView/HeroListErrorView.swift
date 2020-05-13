//
//  HeroListErrorView.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import UIKit

protocol HeroListErrorViewOutput: class {
    func didTapButton()
}

class HeroListErrorView: BaseView {
    
    // IBOutlets
    
    @IBOutlet var errorTitleLabel: UILabel!
    @IBOutlet var errorDescriptionLabel: UILabel!
    @IBOutlet var errorButton: UIButton!
    
    // Variables
    
    weak var output: HeroListErrorViewOutput?
    
    // IBActions
    
    @IBAction func didTapButton(_ sender: Any) {
        output?.didTapButton()
    }
    
    func show(
        in view: UIView,
        title: String = "Error",
        description: String = "Something went wrong. Please try again later",
        buttonTitle: String = "Retry") {
        errorTitleLabel.text = title
        errorDescriptionLabel.text = description
        errorButton.setTitle(buttonTitle, for: .normal)
        
        view.addAndManageConstraint(view: self)
    }
    
    func hide() {
        self.removeFromSuperview()
    }
    
}
