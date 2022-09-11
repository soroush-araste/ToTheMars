//
//  EmptyListView.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import UIKit

class EmptyListView: UIView {
    
    private lazy var mainImageView: UIImageView = {
       var imageView = UIImageView()
        imageView.image = UIImage(named: "empty_box")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mainLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .systemFont(ofSize: 30)
        messageLabel.sizeToFit()
        messageLabel.text = "No items found"
        return messageLabel
    }()
    
    //MARK:  - DEFAULT INITIALIZER
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CREATE UI
    private func createUI() {
        addingMainImageView()
        addingMainLabel()
    }
    
    private func addingMainImageView() {
        addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            mainImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func addingMainLabel() {
        addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20)
        ])
    }
}
