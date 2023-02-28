//
//  AppsViewController.swift
//  AppStore
//
//  Created by Emir Alkal on 25.02.2023.
//

import UIKit

final class AppsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private static let cellId = "AppsViewController"
    private static let headerId = "Header"
    
    var socialApps = [SocialApp]()
    var groups = [Feed]()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupCollectionView()
        fetchJSONData()
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchJSONData() {
        var group1: Feed?
        var group2: Feed?
        var socialApps: [SocialApp]?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        NetworkService.shared.fetchTopFree { result in
            dispatchGroup.leave()
            switch result {
            case .success(let feed):
                group1 = feed
            case .failure(let failure):
                print(failure)
            }
        }
        
        dispatchGroup.enter()
        NetworkService.shared.fetchPaidApps { result in
            dispatchGroup.leave()
            switch result {
            case .success(let feed):
                group2 = feed
            case .failure(let failure):
                print(failure)
            }
        }
        
        dispatchGroup.enter()
        NetworkService.shared.fetchSocialApps { result in
            dispatchGroup.leave()
            switch result {
            case .success(let apps):
                socialApps = apps
            case .failure(let failure):
                print(failure)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let group1 {
                self.groups.append(group1)
            }
            if let group2 {
                self.groups.append(group2)
            }
            self.socialApps = socialApps ?? []
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsViewController.cellId)
        collectionView.register(AppsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsViewController.headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsViewController.headerId, for: indexPath) as! AppsHeader
        header.appHeaderHorizontalController.socialApps = socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.size.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsViewController.cellId, for: indexPath) as! AppsGroupCell
        let feed = groups[indexPath.item]
        cell.titleLabel.text = feed.title
        cell.horizontalController.feed = feed
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler =  { [weak self] app in
            guard let self else { return }
            let detailVC = AppDetailViewController()
            detailVC.view.backgroundColor = .white
            detailVC.navigationItem.title = app.name
            detailVC.appId = app.id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
