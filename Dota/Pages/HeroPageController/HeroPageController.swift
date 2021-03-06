//
//  HeroPageController.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import UIKit
import Segmentio
import RxSwift
import RxCocoa
import RxDataSources

class HeroPageController: UIViewController {
    
    // Variables
    
    var viewModel: HeroPageViewModel!
    weak var listOutput: HeroListViewOutput?
    private let disposeBag = DisposeBag()
    private let loadingView = HeroListLoadingView()
    private let errorView = HeroListErrorView()
    private let listView = HeroListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbarImage()
        setupChildView()
        setupRx()
    }
    
    private func setupNavbarImage() {
        let logoImage = UIImage.init(named: "Logo")
        self.navigationItem.titleView = UIImageView(image: logoImage)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupChildView() {
        listView.viewModel = HeroListViewModel()
        listView.output = listOutput
        errorView.output = self
    }
    
    private func setupRx() {
        viewModel.isLoading
            .subscribe(onNext: { [weak self] (isLoading) in
                if (isLoading) {
                    self?.showLoading()
                } else {
                    self?.loadingView.hide()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.error
            .subscribe(onNext: { [weak self] (error) in
                if (error != "") {
                    self?.showError(message: error)
                } else {
                    self?.errorView.hide()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.hasData
            .subscribe(onNext: { [weak self] (hasData) in
                if (hasData) {
                    self?.showList()
                } else {
                    self?.listView.hide()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func resetState() {
        loadingView.hide()
        errorView.hide()
        listView.hide()
    }
    
    private func showLoading() {
        resetState()
        loadingView.show(in: self.view)
    }
    
    private func showError(message: String) {
        resetState()
        errorView.show(in: self.view, description: message)
    }
    
    private func showList() {
        resetState()
        listView.show(in: self.view)
    }
}

extension HeroPageController: HeroListErrorViewOutput {
    
    func didTapButton() {
        viewModel.reload()
    }
    
}
