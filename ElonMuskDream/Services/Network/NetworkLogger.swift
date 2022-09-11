//
//  NetworkLogger.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/11/22.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest, data: Data?, response: HTTPURLResponse?) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        print("🔥🔥🔥 Request URL 🔥🔥🔥")
        print(request)
        print("- - - - - - - - - - Request Method - - - - - - - - - -")
        print(request.httpMethod ?? "")
        print("- - - - - - - - - - Request Headers - - - - - - - - - -")
        request.allHTTPHeaderFields?
            .map { "\($0): \($1)" }
            .forEach { print($0) }
        
        print("- - - - - - - - - - Response Status Code - - - - - - - ")
        print(response?.statusCode ?? "no status code")
        print("- - - - - - - - - - - - - - - - - - - - - - - - - - - -")
        
        request.httpBody
            .map { String(decoding: $0, as: UTF8.self) }
            .map { print("- - - - - - - - - - Request Body - - - - - - - - - -\n\($0)") }
        
        print("- - - - - - - - - - Response status code - - - - - - - - - -")
        print(response?.statusCode ?? "no status code")
        print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -")
        
        data
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: .allowFragments) }
            .flatMap { try? JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) }
            .map { String(decoding: $0, as: UTF8.self) }
            .map { "🔥🔥🔥 Response 🔥🔥🔥\n\($0)" }
            .map { print($0) }
    }

    static func log(response: URLResponse) {}
}
