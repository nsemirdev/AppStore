//
//  AppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by Emir Alkal on 26.02.2023.
//

import UIKit

final class AppsHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    private static let cellId = "AppsHeaderHorizontalController"
    var socialApps = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: AppsHeaderHorizontalController.cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.size.width * 0.9, height: view.frame.size.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        socialApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderHorizontalController.cellId, for: indexPath) as! AppsHeaderCell
        cell.companyLabel.text = socialApps[indexPath.item].name
        cell.imageView.sd_setImage(with: URL(string: socialApps[indexPath.item].imageUrl))
        cell.titleLabel.text = socialApps[indexPath.item].tagline
        return cell
    }
}
