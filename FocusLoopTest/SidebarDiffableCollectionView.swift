//
//  SidebarCollectionView.swift
//  FocusLoopTest
//
//  Created by Majd Taby on 2/23/24.
//

import UIKit
import SwiftUI

class HeaderView: UICollectionReusableView {
    var uikitTextField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        uikitTextField = UITextField(frame: bounds)
        uikitTextField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        uikitTextField.placeholder = "Header UIKit TextField"
        addSubview(uikitTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SidebarCollectionView: UIViewController {

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!

    enum Section { case main }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.selectionFollowsFocus = true
        collectionView.allowsFocus = true
        view.addSubview(collectionView)

        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<HeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { supplementaryView, elementKind, indexPath in

        }

        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> {
            cell, indexPath, itemIdentifier in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = "\(itemIdentifier)"
            cell.contentConfiguration = configuration
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Int>(
            collectionView: collectionView
        ) {
            collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier
            )
        }

        dataSource.supplementaryViewProvider = { [unowned self] (
            collectionView, elementKind, indexPath
        ) -> UICollectionReusableView? in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration,
                for: indexPath
            )
        }

        collectionView.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<10), toSection: .main)
        dataSource.apply(snapshot)
    }    

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
