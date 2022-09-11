//
//  Repository.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/8/22.
//

import Foundation

enum RepositoryError: Error {
    case notFound
    case noInternet(message: String)
    case tryLater
    case serverError
    case unknownError
    
    var canRetry: Bool {
        switch self {
        case .serverError, .noInternet, .unknownError:
            return true
        default:
            return false
        }
    }
    
    var localizedStrings: String {
        switch self {
        case .notFound:
            return "Item not found!"
        case .noInternet(let message):
            return message
        case .tryLater:
            return "Please try later"
        case .serverError:
            return "Server has issue at this time"
        case .unknownError:
            return "unknown error happened"
        }
    }
}

protocol Repository {
    associatedtype T
    
    func getAll(page: UInt, completionHandler: @escaping(Result<[T], RepositoryError>) -> Void)
}
