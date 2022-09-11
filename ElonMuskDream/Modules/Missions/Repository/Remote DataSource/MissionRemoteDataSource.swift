//
//  MissionRemoteDataSource.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation

final class MissionRemoteDataSource: MissionDataSource {
    func saveItems(items: [DomainMission]) {
        
    }
    
    func getAllMissions(page: UInt, completionHandler: @escaping (Result<[DomainMission], Error>)->Void) {
        MissionService.getLaunchesList(request: .init(options: Options(page: page))) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                completionHandler(.success(self.mapDataModelToDomainModel(model:response)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func mapDataModelToDomainModel(model: MissionService.Response) -> [DomainMission] {
        var domainModel: [DomainMission] = []
        domainModel.reserveCapacity(model.docs.count)
        let hasNextPage: Bool = model.hasNextPage
        let docs: [Doc] = model.docs
        for item in docs {
            let domainMission = DomainMission(id: item.id,
                                              success: item.success ?? false,
                                              rocketName: item.name,
                                              details: item.details ?? "No Details",
                                              flightNumber: item.flightNumber,
                                              smallImage: item.links.patch.small,
                                              largeImage: item.links.patch.small,
                                              launchDate: item.dateUnix,
                                              upcoming: item.upcoming,
                                              crewCount: item.crew.count,
                                              hasNextPage: hasNextPage,
                                              youtubeLink: item.links.webcast,
                                              youtubeID: item.links.youtubeID,
                                              wikipediaLink: item.links.wikipedia,
                                              flickerImages: item.links.flickr.original
                                              )
            domainModel.append(domainMission)
        }
        return domainModel
    }
}
