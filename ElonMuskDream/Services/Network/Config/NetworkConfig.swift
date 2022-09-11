//
//  NetworkConfig.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/11/22.
//

import Foundation

struct NetworkConfig {

    enum APIVersion: String {
        case v5
    }
    
    enum APIEnvironment {
        case production
        case development
        
        static var defaultValue: Self = .production
    }
    
    struct RequestHeader {
        static let defaultValues = [
            "Content-Type" : "application/json",
        ]
        
        static func getDefaultHeaderWithToken() -> [String : String] {
            return [
                "Content-Type" : "application/json",
                "user-device": "ios",
            ]
        }
    }
}
