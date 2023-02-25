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
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyView()
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupEmptyView() {
        view.addSubview(enterSearchTermLabel)
        
        NSLayoutConstraint.activate([
            enterSearchTermLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            enterSearchTermLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            enterSearchTermLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            enterSearchTermLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchViewController.cellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = results.count != 0
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewController.cellID, for: indexPath) as! SearchResultCell
        cell.appResult = results[indexPath.item]
        return cell
    }
    
    var timer: Timer?
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            NetworkService.shared.fetchApps(searchTerm: self.searchController.searchBar.text!) { result in
                switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.results = results
                        self.collectionView.reloadData()
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        })
    }
}
