//
//  ImagesCollectionViewCell.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import UIKit
import Kingfisher

class RocketImagesCollectionViewCell: UICollectionViewCell {
    
    private lazy var rocketImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.addCornerRadius()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator =  UIActivityIndicatorView()
        
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        contentView.addSubview(rocketImageView)
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rocketImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rocketImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rocketImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rocketImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        rocketImageView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 15),
            activityIndicator.heightAnchor.constraint(equalToConstant: 15),
            activityIndicator.centerXAnchor.constraint(equalTo: rocketImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: rocketImageView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func configCellData(image: String) {
        if let url = URL(string: image) {
            rocketImageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: "rocket")?.withRenderingMode(.alwaysTemplate),
                                    options: [
                                        .loadDiskFileSynchronously,
                                        .cacheOriginalImage,
                                        .transition(.fade(0.25))
                                    ]) { [weak self] result in
                                        self?.activityIndicator.stopAnimating()
                                    }
        }
    }
}
