//
//  HeroListView.swift
//  Dota
//
//  Created by erdhee on 13/05/20.
//  Copyright © 2020 erdhee. All rights reserved.
//

import Foundation
import UIKit
import Segmentio
import RxDataSources
import RxSwift
import RxCocoa

protocol HeroListViewOutput: class {
    func didSelectHero(hero: HeroObject?)
}

class HeroListView: BaseView {
    
    // IBOutlets
    
    @IBOutlet var segmentedControl: Segmentio!
    @IBOutlet var collectionView: UICollectionView!
    
    // Variables

    private let disposeBag: DisposeBag = DisposeBag()
    private let cellIdentifier = "heroCellIdentifier"
    private var datasource: RxCollectionViewSectionedAnimatedDataSource<SectionHeroCollectionData>!
    weak var output: HeroListViewOutput?
    var viewModel: HeroListViewModel = HeroListViewModel() {
        didSet {
            setupSegmentControl()
            setupCollectionView()
        }
    }
    
    // Initialization
    
    private func setupCollectionView() {
        let bundle = Bundle(for: HeroCollectionCellView.self)
        let nib = UINib(nibName: "HeroCollectionCellView", bundle: bundle)
        
        datasource = RxCollectionViewSectionedAnimatedDataSource<SectionHeroCollectionData>(configureCell: { (datasource, collectionView, indexPath, model) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? HeroCollectionCellView else {
                return UICollectionViewCell()
            }

            cell.configure(data: model)
            return cell
        })

        self.collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.collectionItems
            .bind(to: collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    private func setupSegmentControl() {
        viewModel.segmentItems.map { (items) -> [SegmentioItem] in
            return items.map { (item) -> SegmentioItem in
                return SegmentioItem(title: item.label, image: UIImage())
            }
        }
        .subscribe(onNext: { [weak self] (items) in
            let defaultState = SegmentioState(
                backgroundColor: Colors.nightRider,
                titleTextColor: UIColor.white,
                titleAlpha: 0.5)

            let selectedState = SegmentioState(
                backgroundColor: Colors.nightRider,
                titleTextColor: UIColor.white,
                titleAlpha: 1.0)

            let states = (defaultState, selectedState, selectedState)

            self?.segmentedControl.setup(content: items, style: .onlyLabel, options: SegmentioOptions(
                backgroundColor: Colors.nightRider,
                segmentPosition: .dynamic,
                scrollEnabled: true,
                indicatorOptions: SegmentioIndicatorOptions(type: .bottom, height: 2.0, color: Colors.cinnabar),
                horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(type: .none), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(color: Colors.nightRider), labelTextAlignment: .center,
                labelTextNumberOfLines: 1,
                segmentStates: states
            ))

            self?.segmentedControl.selectedSegmentioIndex = 0
            self?.segmentedControl.valueDidChange = { [weak self] segmentio, segmentIndex in
                self?.viewModel.setSelectedSegment(index: segmentIndex)
            }
        })
        .disposed(by: disposeBag)
    }
    
    func show(in view: UIView) {
        view.addAndManageConstraint(view: self)
    }
    
    func hide() {
        self.removeFromSuperview()
    }
}

extension HeroListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
        var height = size
        
        if (height < 164) {
            height = height + (height * 0.1)
        }

        return CGSize(width: size, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: HeroCollectionCellViewData = datasource[indexPath]
        
        output?.didSelectHero(hero: item.heroObject)
    }
}
