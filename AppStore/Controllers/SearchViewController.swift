//
//  SearchViewController.swift
//  AppStore
//
//  Created by Emir Alkal on 25.02.2023.
//

import UIKit
import SDWebImage

final class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private static let cellID = "SearchViewController"
    private var results = [ApiResult]()
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchApps()
    }
    
    private func fetchApps() {
        NetworkService.shared.fetchApps { result in
            switch result {
            case .success(let results):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.results = results
                    self.collectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchViewController.cellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewController.cellID, for: indexPath) as! SearchResultCell
        cell.appResult = results[indexPath.item]
        return cell
    }
}
