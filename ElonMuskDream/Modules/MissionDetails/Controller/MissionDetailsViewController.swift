//
//  MissionDetailsViewController.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/9/22.
//

import UIKit
import Kingfisher

final class MissionDetailsViewController: UIViewController {
    
    @IBOutlet weak private var mainImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var detailLabel: UILabel!
    @IBOutlet weak private var launchDateLabel: UILabel!
    @IBOutlet weak private var crewNumberLabel: UILabel!
    @IBOutlet private weak var launchSuccessfulButton: UIButton!
    
    @IBOutlet weak private var youtubeButton: UIButton!
    @IBOutlet weak private var wikipediaButton: UIButton!
    @IBOutlet weak private var seeOriginalImagesButton: UIButton!
    
    //MARK: - INITIALIZER
    private let viewModel: MissionDetailsViewModel
    
    init(viewModel: MissionDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW CONTROLLER LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(bookmarkButtonTapped))
        launchSuccessfulButton.addCornerRadius()
        youtubeButton.addCornerRadius()
        wikipediaButton.addCornerRadius()
        seeOriginalImagesButton.addCornerRadius()
        viewModel.updateBookmarkButton = { [weak self] isBookmarked in
            self?.updateBookmarkButton(isBookmarked: isBookmarked)
        }
        updateUI()
    }
}

//MARK: - IBActions
extension MissionDetailsViewController {
    @IBAction func seeMoreImageTouchUpInside(_ sender: Any) {
        let images = viewModel.selectedItem.flickerImages
        let destinationVC = RocketImagesViewController()
        destinationVC.images = images
        show(destinationVC, sender: self)
    }
    
    @IBAction func YoutubeButtonTouchUpInside(_ sender: Any) {
        if let youtubeURL = URL(string: "youtube://\(viewModel.getYoutubeURL().id)"),
           UIApplication.shared.canOpenURL(youtubeURL) {
           UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else if let youtubeURL = viewModel.getYoutubeURL().url {
           UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func wikipediaButtonTouchUpInside(_ sender: Any) {
        if let wikipediaURL = viewModel.getWikipediaURL() {
           UIApplication.shared.open(wikipediaURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func bookmarkButtonTapped() {
        viewModel.handleBookmarkStatus()
    }
    
    func updateBookmarkButton(isBookmarked: Bool) {
        if isBookmarked {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
        }
    }
}

//MARK: - UPDATE UI
extension MissionDetailsViewController {
    private func updateUI() {
        updateBookmarkButton(isBookmarked: viewModel.isBookmarked)
        crewNumberLabel.text = viewModel.selectedItem.numberOfCrews
        titleLabel.text = viewModel.selectedItem.rocketName
        detailLabel.text = viewModel.selectedItem.details
        launchDateLabel.text = viewModel.selectedItem.launchDataString
        youtubeButton.isHidden = viewModel.youtubeButtonIsHidden()
        seeOriginalImagesButton.isHidden = viewModel.seeOriginalImagesButtonIsHidden()
        wikipediaButton.isHidden = viewModel.wikipediaButtonIsHidden()
        launchSuccessfulButton.setTitle(viewModel.selectedItem.launchSuccess, for: .normal)
        launchSuccessfulButton.backgroundColor = viewModel.selectedItem.success ? .systemGreen : .systemRed
        mainImageView.kf.setImage(with: viewModel.selectedItem.largeImageURL,
                                  placeholder: UIImage(named: "rocket")?.withRenderingMode(.alwaysTemplate),
                                options: [
                                    .loadDiskFileSynchronously,
                                    .cacheOriginalImage,
                                    .transition(.fade(0.25)),
                                    ])
    }
}
