//
//  MissionDetailsDataSource.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation

protocol MissionDetailsDataSource {
    func addFavorite(item: DomainMission)
    func getFavoriteStatus(item: DomainMission) -> Bool
    func deleteFavorite(item: DomainMission) -> Bool
}
