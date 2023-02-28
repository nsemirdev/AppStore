//
//  PreviewCell.swift
//  AppStore
//
//  Created by Emir Alkal on 28.02.2023.
//

import UIKit

final class PreviewCell: UICollectionViewCell {
    
    let horizontalController = PreviewScreenshotsController()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Preview"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        setupChildVC()
    }
    
    private func setupChildVC() {
        contentView.addSubview(horizontalController.view)
        horizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            horizontalController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
