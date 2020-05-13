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
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        guard let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController,  let viewController = navigationController.viewControllers.first as? HeroPageController else {
            return
        }
        
        viewController.viewModel = viewModel
        viewController.listOutput = self
        navigationController.navigationBar.tintColor = Colors.alto
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : Colors.alto]
        
        self.navigationController = navigationController
        self.window?.rootViewController = navigationController
    }
    
}

extension AppCoordinator: HeroListViewOutput {
    
    func didSelectHero(hero: HeroObject?) {
        guard let hero = hero else { return }
        
        let bundle = Bundle(for: HeroDetailPageController.self)
        let storyboard = UIStoryboard(name: HeroDetailPageController.className(), bundle: bundle)
        let viewModel = HeroDetailPageViewModel(hero: hero)
        guard let viewController = storyboard.instantiateInitialViewController() as? HeroDetailPageController else {
            return
        }
        
        viewController.viewModel = viewModel
        viewController.output = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
