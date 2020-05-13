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
    var collectionItems: BehaviorSubject<[HeroCollectionCellViewData]> = BehaviorSubject<[HeroCollectionCellViewData]>(value: [])
    var role: BehaviorSubject<SegmentItemData>!
    
    init() {
        var _segmentItems: [SegmentItemData] = [];
        let defaultSegmentItem = SegmentItemData(label: "All Heroes")
        
        role = BehaviorSubject<SegmentItemData>(value: defaultSegmentItem)
        
        _segmentItems.append(defaultSegmentItem)
        _segmentItems.append(contentsOf: RoleDataService.shared.get().map({ (role) -> SegmentItemData in
            return SegmentItemData(label: role.name ?? "", model: role)
        }))
        
        segmentItems.onNext(_segmentItems)
        
        role.asObservable()
            .map { (segment) -> RoleObject? in
                return segment.model
            }
            .map { (role) -> [HeroObject] in
                return HeroDataService.shared.get(role: role)
            }
            .map({ (heroes) -> [HeroCollectionCellViewData] in
                return heroes.map { (hero) -> HeroCollectionCellViewData in
                    return HeroCollectionCellViewData(hero: hero)
                }
            })
            .subscribe(onNext: { [weak self] (heroes) in
                self?.collectionItems.onNext(heroes)
            })
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
