//
//  HeroPageViewModel.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import Moya

class HeroPageViewModel {
    var isLoading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    var error: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var hasData: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    private let provider: MoyaProvider<OpenDotaApi> = MoyaProvider<OpenDotaApi>()
    private let disposeBag = DisposeBag()
    
    init() {
        // Fetch local heroes first to pre-fill data
        HeroDataService.shared
            .get(role: nil)
            .subscribe(onNext: { [weak self] (heroes) in
                if (heroes.count > 0) {
                    self?.hasData.onNext(true)
                }
                
                self?.reload()
            })
            .dispose()
    }
    
    func reload() {
        showLoading()
        
        // Get Data from API
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        provider.rx.request(.getAllHeroes)
        .filterSuccessfulStatusAndRedirectCodes()
        .map([HeroModel].self, using: decoder)
        .map { (heroes) -> [HeroObject] in
            return HeroDataService.shared.add(heroes: heroes)
        }
        .subscribe(onSuccess: { [weak self] (heroes) in
            self?.hasData.onNext(heroes.count > 0)
        }) { [weak self] (error) in
            if let error = error as? MoyaError {
                switch (error) {
                case .underlying(let nsError as NSError, _):
                    self?.error.onNext(ErrorHelper.shared.getMessage(error: nsError))
                default:
                    self?.error.onNext(ErrorHelper.shared.getMessage(error: error))
                }
            }
        }
    .disposed(by: disposeBag)
    }
    
    func showLoading() {
        if (try! hasData.value()) {
            return
        }
        
        isLoading.onNext(true)
    }
    
    func hideLoading() {
        if (try! hasData.value()) {
            return
        }
        
        isLoading.onNext(false)
    }
}
