//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by Emir Alkal on 27.02.2023.
//

import UIKit

final class AppDetailViewController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    private let cellId = "AppDetailViewController"
    private let detailCellId = "DetailCellID"
    var app: ApiResult?
    
    var appId: String? {
        didSet {
            NetworkService.shared.fetchByAppID(appId: appId!) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let result):
                    let app = result.results.first
                    self.app = app
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupCollectionView() {
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: detailCellId)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        if indexPath.item == 1 {
            return .init(width: view.frame.size.width, height: 500)
        }
        
        let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.size.width, height: 1000))
        dummyCell.releaseNotesLabel.text = app?.releaseNotes
        dummyCell.nameLabel.text = app?.trackName
        dummyCell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        dummyCell.priceButton.setTitle(app?.formattedPrice, for: .normal)
        dummyCell.layoutIfNeeded()

        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.size.width, height: 1000))
        return .init(width: view.frame.size.width, height: estimatedSize.height)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailCell
            cell.nameLabel.text = app?.trackName
            cell.releaseNotesLabel.text = app?.releaseNotes
            cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            cell.priceButton.setTitle(app?.formattedPrice, for: .normal)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.app = self.app
            return cell
        }
    }
}
