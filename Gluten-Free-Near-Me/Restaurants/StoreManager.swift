//
//  StoreManager.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/4/24.
//

import Foundation

class StoreManager : ObservableObject {
    @Published private(set) var saved:Set<Restaurant> = []
    @Published private(set) var searchResults:Set<Restaurant> = []
    @Published private(set) var cache:Set<Restaurant> = []
    
    func addSearchResult(place:Restaurant) -> Void {
        // If the place exists in our saved list, insert the stored version
        // to render it
        if (saved.contains(place)) {
            guard let storedVersion = saved.first(where: { $0 == place }) else { return; }
            searchResults.insert(storedVersion)
        }
        searchResults.insert(place)
    }
    
    func save(place:Restaurant) {
        var savedVersion = place
        savedVersion.isSaved = true
        saved.insert(savedVersion);
    }
    
    func unsave(place:Restaurant) {
        saved.remove(place)
    }
    
    func cacheSearch() -> Void {
        for place:Restaurant in searchResults {
            cache.insert(place)
        }
    }
    
    func clear() -> Void {
        searchResults = []
    }
    
    // Always display saved restaurants.
    
    // Only display searchRestaurants before a new search is performed.
    // Always cache the search results during the session.
    
    // See if restaurant exists in cache or saved, then render. Otherwise, API call.
}
