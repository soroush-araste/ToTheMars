//
//  MissionDetailsFactory.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation

final class MissionDetailsFactory {
    
    private let selectedItem: DomainMission
    
    init(selectedItem: DomainMission) {
        self.selectedItem = selectedItem
    }
    
    func makeMissionDetailsViewController() -> MissionDetailsViewController {
        let localDataSource = MissionDetailsLocalDataSource()
        let repository = MissionDetailsRepository(localDataSource: localDataSource)
        let viewModel = MissionDetailsViewModel(selectedMission: selectedItem, repository: repository)
        let vc = MissionDetailsViewController(viewModel: viewModel)
        return vc
    }
}
