//
//  MissionTableViewCell.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/8/22.
//

import UIKit
import Kingfisher

final class MissionTableViewCell: UITableViewCell {
    
    var domainMission: DomainMission? {
        didSet {
            updateUI(data: domainMission)
        }
    }
    
    //MARK: - @IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var rocketNameLabel: UILabel!
    @IBOutlet private weak var rocketDetailsLabel: UILabel!
    @IBOutlet private weak var flightNumberLabel: UILabel!
    @IBOutlet private weak var launchDateLabel: UILabel!
    @IBOutlet private weak var launchSuccessfulButton: UIButton!
    
    //MARK: - DEFAULT INITIALIZER
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        containerView.addCornerRadius()
        containerView.backgroundColor = .systemGray6
        iconImageView.addCornerRadius()
        launchSuccessfulButton.addCornerRadius()
        shadowConfig()
    }
}

extension MissionTableViewCell {
    private func updateUI(data: DomainMission?) {
        guard let data = data else { return }
        rocketNameLabel.text = data.rocketName
        rocketDetailsLabel.text = data.details
        flightNumberLabel.text = data.flightNumberString
        launchDateLabel.text = data.launchDataString
        launchSuccessfulButton.setTitle(data.launchSuccess, for: .normal)
        launchSuccessfulButton.backgroundColor = data.success ? .systemGreen : .systemRed
        iconImageView.kf.setImage(with: data.smallImageURL,
                                  placeholder: UIImage(named: "rocket")?.withRenderingMode(.alwaysTemplate),
                                options: [
                                    .loadDiskFileSynchronously,
                                    .cacheOriginalImage,
                                    .transition(.fade(0.25)),
                                    ])
    }
}
