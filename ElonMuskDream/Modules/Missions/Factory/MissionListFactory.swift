//
//  MissionListFactory.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation

final class MissionListFactory {
    func makeMissionListViewController() -> MissionListViewController {
        let remoteDataSource = MissionRemoteDataSource()
        let localDataSource = MissionLocalDataSource()
        let repository = MissionRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        let viewModel = MissionListViewModel(repository: repository)
        let vc = MissionListViewController(viewModel: viewModel)
        return vc
    }
}
