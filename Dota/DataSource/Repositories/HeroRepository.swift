//
//  HeroRepository.swift
//  Dota
//
//  Created by erdhee on 12/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class HeroRepository {
    static let shared: HeroRepository = HeroRepository()
    let provider: MoyaProvider<OpenDotaApi> = MoyaProvider<OpenDotaApi>()
    
    /**
     * Get list of heroes. Juggling from Local data and API
     * @return:
     * - Observable<[HeroObject]>
     */
    
    func getHeroes() -> Observable<[HeroObject]> {
        return Observable.create { (subscriber) -> Disposable in
            // Fetching from Realm first
            let localHeroes: [HeroObject] = HeroDataService.shared.get(role: nil);
            
            subscriber.onNext(localHeroes)
            
            // Get data from API
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return self.provider.rx.request(.getAllHeroes)
                .filterSuccessfulStatusAndRedirectCodes()
                .map([HeroModel].self, using: decoder)
                .map { (heroes) -> [HeroObject] in
                    return HeroDataService.shared.add(heroes: heroes)
                }.subscribe(onSuccess: { (heroes) in
                    subscriber.onNext(heroes)
                }) { (error) in
                    subscriber.onError(error)
                }
        }
    }
}
