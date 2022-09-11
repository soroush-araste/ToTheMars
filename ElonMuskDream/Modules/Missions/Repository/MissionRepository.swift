//
//  MissionRepository.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation

class MissionRepository: Repository {
    
    typealias T = DomainMission
    
    private let remoteDataSource: MissionDataSource
    private let localDataSource: MissionDataSource
    
    init(remoteDataSource: MissionDataSource, localDataSource: MissionDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getAll(page: UInt, completionHandler: @escaping(Result<[DomainMission], RepositoryError>) -> Void) {
        remoteDataSource.getAllMissions(page: page) { result in
            switch result {
            case .success(let domainData):
                completionHandler(.success(domainData))
            case .failure(let error):
                if let error = error as? NetworkError {
                    switch error {
                    case .tooManyRequest:
                        completionHandler(.failure(.tryLater))
                    case .unknown:
                        completionHandler(.failure(.unknownError))
                    case .noInternetConnection(let message):
                        completionHandler(.failure(.noInternet(message: message)))
                    default:
                        completionHandler(.failure(.serverError))
                    }
                }
                completionHandler(.failure(.unknownError))
            }
        }
    }
}
