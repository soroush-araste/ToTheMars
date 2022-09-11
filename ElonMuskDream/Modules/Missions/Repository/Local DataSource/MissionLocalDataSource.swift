//
//  MissionLocalDataSource.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation
import CoreData

final class MissionLocalDataSource: MissionDataSource {
    
    /*
     Interface Segregation Principal Violation!
     
     If I had extra time, I would have implement read and write Mission Data on
     data base
     
     */
    
    func getAllMissions(page: UInt, completionHandler: @escaping (Result<[DomainMission], Error>) -> Void) {
        
    }
    
    func saveItems(items: [DomainMission]) {
        
    }
}
