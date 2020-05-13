//
//  AppCoordinator.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    public func run() {
        let bundle = Bundle(for: HeroPageController.self)
        let storyboard = UIStoryboard(name: HeroPageController.className(), bundle: bundle)
        let viewModel = HeroPageViewModel()
        guard let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController,  let viewController = navigationController.viewControllers.first as? HeroPageController else {
            return
        }
        
        viewController.viewModel = viewModel
        
        self.navigationController = navigationController
        self.window?.rootViewController = navigationController
    }
    
}
