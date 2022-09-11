//
//  MissionDataSourceProtocol.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation

protocol MissionDataSource {
    func getAllMissions(page: UInt, completionHandler: @escaping (Result<[DomainMission], Error>)->Void)
    func saveItems(items: [DomainMission])
}
