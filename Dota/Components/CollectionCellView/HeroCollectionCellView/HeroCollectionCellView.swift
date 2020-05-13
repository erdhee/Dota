//
//  HeroCollectionCellView.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCollectionCellView: UICollectionViewCell {

    // IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroRoleLabel: UILabel!
    @IBOutlet weak var heroAttributeLabel: UILabel!
    @IBOutlet weak var heroAttributeIndicator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: HeroCollectionCellViewData) {
        imageView.kf.setImage(with: data.imageUrl)
        heroNameLabel.text = data.heroName
        heroRoleLabel.text = data.heroRole
        heroAttributeLabel.text = data.heroAttribute?.rawValue.capitalized
        heroAttributeIndicator.backgroundColor = getAttributeColor(attribute: data.heroAttribute)
    }
    
    func getAttributeColor(attribute: HeroAttributeType?) -> UIColor {
        guard let attribute = attribute else {
            return UIColor.clear
        }
        
        switch attribute {
        case .str:
            return Colors.cinnabar
        case .agi:
            return Colors.malachite
        case .int:
            return Colors.royalBlue
        }
    }
}
