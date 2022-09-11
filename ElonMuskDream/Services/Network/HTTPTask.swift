//
//  HTTPTask.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/11/22.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask<T: Encodable> {
    case urlRequest(urlParameters: Parameters)
    case jsonRequest(request: T)
    case jsonAndURLRequest(urlParameters: Parameters, request: T)
}
