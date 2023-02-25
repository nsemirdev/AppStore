//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Emir Alkal on 25.02.2023.
//

import UIKit

final class SearchResultCell: UICollectionViewCell {
    
    var appResult: ApiResult! {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0.0)"
            imageView.sd_setImage(with: URL(string: appResult.artworkUrl100))
            screenShot1.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            if appResult.screenshotUrls.count > 1 {
                screenShot2.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            if appResult.screenshotUrls.count > 2 {
                screenShot3.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Video"
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .init(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    lazy var screenShot1 = createScreenShotImageView()
    lazy var screenShot2 = createScreenShotImageView()
    lazy var screenShot3 = createScreenShotImageView()
    
    private func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    private func setupSubviews() {
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        labelsStackView.axis = .vertical
                
        let infoStackView = UIStackView(arrangedSubviews: [imageView, labelsStackView, getButton])
        infoStackView.alignment = .center
        infoStackView.spacing = 12
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [screenShot1, screenShot2, screenShot3])
        screenShotsStackView.spacing = 8
        screenShotsStackView.distribution = .fillEqually
        
        let overallStackView = UIStackView(arrangedSubviews: [infoStackView, screenShotsStackView])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .vertical
        overallStackView.spacing = 16
        
        addSubview(overallStackView)
        
        NSLayoutConstraint.activate([
            overallStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
