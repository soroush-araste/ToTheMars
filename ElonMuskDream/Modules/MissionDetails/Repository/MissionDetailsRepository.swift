//
//  MissionDetailsRepository.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation

protocol MissionDetailRepository {
    func addFavorite(item: DomainMission)
    func getFavoriteStatus(item: DomainMission) -> Bool
    func deleteFavorite(item: DomainMission) -> Bool
}

class MissionDetailsRepository: MissionDetailRepository {
    
    private let localDataSource: MissionDetailsDataSource
    
    init(localDataSource: MissionDetailsDataSource) {
        self.localDataSource = localDataSource
    }
    
    func addFavorite(item: DomainMission) {
        localDataSource.addFavorite(item: item)
    }
    
    func getFavoriteStatus(item: DomainMission) -> Bool {
        localDataSource.getFavoriteStatus(item: item)
    }
    
    func deleteFavorite(item: DomainMission) -> Bool {
        localDataSource.deleteFavorite(item: item)
    }
    
}
