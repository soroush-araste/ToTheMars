//
//  MissionDetailsLocalDataSource.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation
import CoreData

class MissionDetailsLocalDataSource: MissionDetailsDataSource {
    func deleteFavorite(item: DomainMission) -> Bool {
        let fetchRequest = NSFetchRequest<CDFavorite>(entityName: "CDFavorite")
        let predicate = NSPredicate(format: "id==%@", item.id)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard let item = result else { return false }
            PersistentStorage.shared.context.delete(item)
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    func addFavorite(item: DomainMission) {
        let newItem = CDFavorite(context: PersistentStorage.shared.context)
        newItem.id = item.id
        PersistentStorage.shared.saveContext()
    }
    
    func getFavoriteStatus(item: DomainMission) -> Bool {
        let fetchRequest = NSFetchRequest<CDFavorite>(entityName: "CDFavorite")
        let predicate = NSPredicate(format: "id==%@", item.id)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return false }
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
}
