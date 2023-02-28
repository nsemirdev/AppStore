//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Emir Alkal on 27.02.2023.
//

import UIKit

final class AppDetailCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        imageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    let priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("$4.99", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let whatsNewLabel: UILabel = {
        let label = UILabel()
        label.text = "Whats new"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.text = "Release notes..."
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    private func setupStackView() {
        let dummyStack = UIStackView(arrangedSubviews: [priceButton, UIView()])
        let labelsVerticalStack = UIStackView(arrangedSubviews: [nameLabel, dummyStack])
        labelsVerticalStack.axis = .vertical
        labelsVerticalStack.spacing = 12
        
        let horizontalStack = UIStackView(arrangedSubviews: [imageView, labelsVerticalStack])
        horizontalStack.spacing = 16
        
        let stackView = UIStackView(arrangedSubviews: [horizontalStack, whatsNewLabel, releaseNotesLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
