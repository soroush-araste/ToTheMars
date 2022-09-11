//
//  MissionDetailsViewModel.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import Foundation


final class MissionDetailsViewModel {
    
    var updateBookmarkButton: ((Bool)->Void)?
    
    //MARK: - PROPERTIES
    var isBookmarked: Bool {
        return checkItemIsBookmarked()
    }
    
    var selectedItem: DomainMission {
        selectedMission
    }
    
    private let selectedMission: DomainMission
    private let repository: MissionDetailRepository
    
    init(selectedMission: DomainMission, repository: MissionDetailRepository) {
        self.selectedMission = selectedMission
        self.repository = repository
    }
    
    
    //MARK: - METHODS
    func youtubeButtonIsHidden() -> Bool {
        guard let youtubeLink = selectedMission.youtubeLink,
           youtubeLink.isEmpty == false else { return true }
        return false
    }
    
    func wikipediaButtonIsHidden() -> Bool {
        guard let wikipediaLink = selectedMission.wikipediaLink,
              wikipediaLink.isEmpty == false else { return true}
        return false
    }
    
    func seeOriginalImagesButtonIsHidden() -> Bool {
        guard selectedMission.flickerImages.isEmpty == false else { return true }
        return false
    }
    
    func getYoutubeURL() -> (url: URL?, id: String) {
        guard let youtubeLink = selectedMission.youtubeLink,
              let youtubeID = selectedMission.youtubeID else { return (url: nil, id: "") }
        return (url: URL(string: youtubeLink), id: youtubeID)
    }
    
    func getWikipediaURL() -> URL? {
        guard let wikipedia = selectedMission.wikipediaLink else { return nil }
        return URL(string: wikipedia)
    }
    
    func checkItemIsBookmarked() -> Bool {
        repository.getFavoriteStatus(item: selectedItem) ? true : false
    }
    
    func handleBookmarkStatus() {
        if isBookmarked {
            //The button is already has bookmarked style and it will change
            if repository.deleteFavorite(item: selectedItem) {
                updateBookmarkButton?(false)
            }
        } else {
            repository.addFavorite(item: selectedMission)
            updateBookmarkButton?(true)
        }
    }
}
