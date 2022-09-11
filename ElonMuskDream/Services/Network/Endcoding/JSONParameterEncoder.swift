//
//  JSONParameterEncoder.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/11/22.
//

import Foundation

public struct JSONParameterEncoder<Request: Encodable> {
    public func encode(urlRequest: inout URLRequest, with model: Request) throws {
        do {
            let data = try JSONEncoder().encode(model)
            urlRequest.httpBody = data
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
