//
//  DomainMission.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation

struct DomainMission: Hashable {
    let id: String
    let success: Bool
    let rocketName: String
    let details: String
    let flightNumber: Int
    let smallImage: String
    let largeImage: String
    let launchDate: Int
    let upcoming: Bool
    let crewCount: Int
    let hasNextPage: Bool
    let youtubeLink: String?
    let youtubeID: String?
    let wikipediaLink: String?
    let flickerImages: [String]
}

extension DomainMission {
    private func stringFromUnix(dateUnix: Int) -> String {
        let dateUnixDouble = Double(dateUnix)
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: dateUnixDouble)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    var flightNumberString: String {
        return "Flight.No \(self.flightNumber)"
    }
    
    var launchDataString: String {
        return stringFromUnix(dateUnix: self.launchDate)
    }
    
    var launchSuccess: String {
        return self.success ? "Success" : "Failure"
    }
    
    var smallImageURL: URL? {
        return URL(string: self.smallImage)
    }
    
    var largeImageURL: URL? {
        return URL(string: self.largeImage)
    }
    
    var numberOfCrews: String {
        return "Number Of Crews: \(self.crewCount)"
    }
}
