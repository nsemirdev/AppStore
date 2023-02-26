//
//  AppsHeaderCell.swift
//  AppStore
//
//  Created by Emir Alkal on 26.02.2023.
//

import UIKit

final class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Company"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .blue
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 2
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    private func setupSubviews() {
        let verticalStack = UIStackView(arrangedSubviews: [companyLabel, titleLabel, imageView])
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
