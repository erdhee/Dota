//
//  HeroListViewModel.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class HeroListViewModel {
    
    // Variables
    
    private let disposeBag = DisposeBag()
    var segmentItems: BehaviorSubject<[SegmentItemData]> = BehaviorSubject<[SegmentItemData]>(value: [])
    var collectionItems: BehaviorSubject<[SectionHeroCollectionData]> = BehaviorSubject<[SectionHeroCollectionData]>(value: [])
    var role: BehaviorSubject<SegmentItemData>!
    
    init() {
        let defaultSegmentItem = SegmentItemData(label: "All Heroes")
        
        role = BehaviorSubject<SegmentItemData>(value: defaultSegmentItem)
        
        RoleDataService.shared
            .get()
            .map { (roles) -> [SegmentItemData] in
                var segmentItems: [SegmentItemData] = [defaultSegmentItem]
                
                segmentItems.append(contentsOf: roles.map({ SegmentItemData(label: $0.name ?? "", model: $0) }))

                return segmentItems
            }
            .bind(to: segmentItems)
            .disposed(by: disposeBag)
        
        role.asObservable()
            .map({ $0.model })
            .flatMap { (role) -> Observable<[HeroObject]> in
                return HeroDataService.shared.get(role: role)
            }
            .map({ (heroes) -> [HeroCollectionCellViewData] in
                return heroes.map { (hero) -> HeroCollectionCellViewData in
                    return HeroCollectionCellViewData(hero: hero)
                }
            })
            .map { (heroes) -> [SectionHeroCollectionData] in
                return [SectionHeroCollectionData(header: "", items: heroes)]
            }
            .bind(to: collectionItems)
            .disposed(by: disposeBag)
    }
    
    func setSelectedSegment(index: Int) {
        guard let item = try! segmentItems.value()[safe: index] else { return }
        
        role.onNext(item)
    }
    
}

struct SegmentItemData {
    var label: String
    var model: RoleObject?
}

struct SectionHeroCollectionData {
    var header: String
    var items: [Item]
}

extension SectionHeroCollectionData: AnimatableSectionModelType {
    typealias Identity = String
    typealias Item = HeroCollectionCellViewData
    
    init(original: SectionHeroCollectionData, items: [Item]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return "Hero"
    }
}
