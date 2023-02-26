//
//  AppsHeader.swift
//  AppStore
//
//  Created by Emir Alkal on 26.02.2023.
//

import UIKit

final class AppsHeader: UICollectionReusableView {
    
    let appHeaderHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChildVC()
    }
    
    private func setupChildVC() {
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appHeaderHorizontalController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            appHeaderHorizontalController.view.topAnchor.constraint(equalTo: topAnchor),
            appHeaderHorizontalController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            appHeaderHorizontalController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
