//
//  MissionsQuery.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/8/22.
//

import Foundation

// MARK: - Options
struct Options: Encodable {
    let limit: Int = 20
    let page: UInt
    let sort: Sort = Sort()
}

// MARK: - Sort
struct Sort: Encodable {
    let flightNumber: String = "desc"

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
    }
}

// MARK: - Query
struct Query: Encodable {
    let upcoming: Bool = false
}
