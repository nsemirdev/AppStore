//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Emir Alkal on 25.02.2023.
//

import UIKit

final class AppsGroupCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    let horizontalController = AppsHorizontalViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupChildVC()
    }
    
    private func setupChildVC() {
        addSubview(horizontalController.view)
        horizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            horizontalController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
