//
//  AppsHorizontalViewController.swift
//  AppStore
//
//  Created by Emir Alkal on 25.02.2023.
//

import UIKit

final class AppsHorizontalViewController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    private static let cellId = "AppsHorizontalViewController"
    var feed: Feed?
    
    var didSelectHandler: ((FeedResult) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppsHorizontalViewController.cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.size.width * 0.9, height: view.frame.size.height * 0.9 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        feed?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHorizontalViewController.cellId, for: indexPath) as! AppRowCell
        cell.nameLabel.text = feed?.results[indexPath.item].name
        cell.imageView.sd_setImage(with: URL(string: feed!.results[indexPath.item].artworkUrl100))
        cell.companyLabel.text = feed?.results[indexPath.item].artistName
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = feed?.results[indexPath.item]
        didSelectHandler?(app!)
    }
}
