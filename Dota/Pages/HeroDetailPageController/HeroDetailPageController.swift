//
//  HeroDetailPageController.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HeroDetailPageController: UIViewController {
    
    // IBOutlets
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerOverlayView: UIView!
    @IBOutlet var roleLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var maxAtkLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var mspdLabel: UILabel!
    @IBOutlet var attributeLabel: UILabel!
    @IBOutlet var similarHeroStackView: UIStackView!
    
    // Variables
    
    var viewModel: HeroDetailPageViewModel?
    weak var output: HeroListViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImageView.kf.setImage(with: viewModel?.hero.getImageUrl())
        roleLabel.text = viewModel?.hero.roles.map({ $0.name ?? "" }).joined(separator: ",")
        typeLabel.text = viewModel?.hero.attackType ?? ""
        maxAtkLabel.text = "\(viewModel?.hero.baseAttackMin.getRoundedStringValue() ?? 0.0.getRoundedStringValue()) - \(viewModel?.hero.baseAttackMax.getRoundedStringValue() ?? 0.0.getRoundedStringValue())"
        healthLabel.text = "\(viewModel?.hero.baseHealth.getRoundedStringValue() ?? 0.0.getRoundedStringValue())"
        mspdLabel.text = "\(viewModel?.hero.moveSpeed.getRoundedStringValue() ?? 0.0.getRoundedStringValue())"
        attributeLabel.text = viewModel?.hero.primaryAttr?.capitalized
        navigationItem.title = viewModel?.hero.localizedName ?? ""
        
        similarHeroStackView.spacing = 8.0
        
        if let similarHeroes = viewModel?.similarHeroes {
            for hero: HeroObject in similarHeroes {
                let item = SimilarHeroItemView()
                
                item.hero = hero
                item.output = output
                
                similarHeroStackView.addArrangedSubview(item)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.headerOverlayView.bounds
        self.headerOverlayView.layer.insertSublayer(gradient, at: 0)
    }
}

extension Double {
    
    func getRoundedStringValue() -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}
