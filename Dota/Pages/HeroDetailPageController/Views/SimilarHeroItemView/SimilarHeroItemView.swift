//
//  SimilarHeroItemView.swift
//  Dota
//
//  Created by erdhee on 14/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import Kingfisher

class SimilarHeroItemView: BaseView {
    
    // IBOutlets
    
    @IBOutlet var heroImageView: UIImageView!
    @IBOutlet var heroNameLabel: UILabel!
    
    // Variables
    
    weak var output: HeroListViewOutput?
    var hero: HeroObject? {
        didSet {
            setupView()
        }
    }
    
    private func setupView() {
        guard let hero = hero else { return }
        
        heroImageView.kf.setImage(with: hero.getImageUrl())
        heroNameLabel.text = hero.localizedName ?? ""
    }
    
    @IBAction func didTapItem(_ sender: Any) {
        output?.didSelectHero(hero: hero)
    }
}
