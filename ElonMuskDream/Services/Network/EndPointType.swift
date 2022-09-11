//
//  EndPointType.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/11/22.
//

import Foundation

protocol EndPointType {
    associatedtype Request: Encodable
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var HTTPMethod: HTTPMethod { get }
    var task: HTTPTask<Request> { get }
    var headers: HTTPHeaders? { get }
    var version: String { get }
}

extension EndPointType {
    var baseURL: URL {
        var urlStr = ""
       
        switch NetworkConfig.APIEnvironment.defaultValue {
        case .production, .development:
            urlStr = "https://api.spacexdata.com/"
        }
        guard let url = URL(string: urlStr) else {
            fatalError("Not Valid URL")
        }
        return url
    }
}
