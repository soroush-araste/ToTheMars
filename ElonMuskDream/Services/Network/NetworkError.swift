//
//  NetworkError.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/11/22.
//

import Foundation

enum NetworkError: Error {
    case missingURL
    case encodingFailed
    case unauthorized
    case forbidden
    case tooManyRequest
    case validation
    case internalServerError
    case unknown
    case unableToDecode(error: Error)
    case noData
    case requestBuildFailed
    case badRequest
    case noInternetConnection(message: String)
    case failed
    case badResponse
    case notFound
}

extension NetworkError {
    var localizedStrings: String {
        switch self {
        case .forbidden:
            return self.localizedDescription
        case .noInternetConnection(let message):
            return message
        case .unableToDecode:
            return "unableToDecode"
        case .internalServerError:
            return "internalServerError"
        case .noData, .failed, .badRequest, .requestBuildFailed:
            return "requestBuildFailed"
        case .unauthorized:
            return "unauthorized"
        default:
            return ""
        }
    }
}
