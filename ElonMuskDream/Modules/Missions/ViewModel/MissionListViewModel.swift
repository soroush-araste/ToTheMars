//
//  MissionListViewModel.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/8/22.
//

import Foundation

final class MissionListViewModel {
    
    //private
    private var missionsList: [DomainMission] = []
    private var page: UInt = 1
    private var canRetry: Bool = false
    
    var updateTableView: (() -> Void)?
    var enableRefreshButton: (() -> Void)?
    var showError: ((_ message: String, _ actionTitle: String) -> Void)?
    
    //MARK: - INITIALIZER
    private let missionRepository: MissionRepository
    
    init(repository: MissionRepository) {
        self.missionRepository = repository
        getMissionList(page: page)
    }
    
    //MARK: - METHODS
    func getAllItems() -> [DomainMission] {
        return missionsList
    }
    func numberOfRows() -> Int {
        return missionsList.count
    }
    
    func itemForRowAt(indexPath: IndexPath) -> DomainMission {
        return missionsList[indexPath.row]
    }
    
    func loadNextPage() {
        if let lastItem = missionsList.last, lastItem.hasNextPage {
            page += 1
            getMissionList(page: page)
        }
    }
    
    func refreshAllDate() {
        page = 1
        missionsList.removeAll()
        updateTableView?()
        getMissionList(page: page)
    }
    
    func retryGettingData() {
        if canRetry {
            getMissionList(page: page)
            canRetry = false
        }
    }
    
    //Sort Missions by launch date
    func sortReceivedData(domainDataList: [DomainMission]) {
        missionsList.append(contentsOf: domainDataList)
        missionsList = missionsList.sorted { $0.launchDate > $1.launchDate}
        updateTableView?()
    }
    
    //Get Data From Repository
    func getMissionList(page: UInt) {
        missionRepository.getAll(page: page) { [weak self] result in
            guard let self = self else { return }
            self.enableRefreshButton?()
            switch result {
            case .success(let domainDataList):
                self.sortReceivedData(domainDataList: domainDataList)
            case .failure(let error):
                if error.canRetry {
                    self.canRetry = true
                    self.showError?(error.localizedStrings, "Retry!")
                } else {
                    self.canRetry = false
                    self.showError?(error.localizedStrings, "Ok")
                }
            }
        }
    }
}
