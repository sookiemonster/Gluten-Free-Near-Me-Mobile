//
//  SearchHandler.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import MapKit
import CoreLocation
import Foundation
import SwiftUI

extension LocationManager {
    
    // Annotations
    // Always render saved restaurants on Map.
    
    // Search RestaurantStack
    // On search, check if any of the googURIs are in the db already
    // If so, use this version within the stack. Then render these afterwards.
    // Otherwise, get results via API
    
    func searchViewport() -> Void {
        // See Apple Docs for Reference: https://developer.apple.com/documentation/mapkit/mklocalsearch/request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "restaurant"
        
        // Only include food establishments
        searchRequest.pointOfInterestFilter = .init(including: [.restaurant, .bakery, .foodMarket, .cafe])
        print("searching")
        
        guard let viewportRegion = viewportRegion else { return ;}
        
        searchRequest.region = viewportRegion
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                print("Error retrieving restaurants.")
                return;
            }
            
            for item in response.mapItems {
                if let name = item.name,
                    let location = item.placemark.location {
                    print(name, location.coordinate)
                }
            }
        }
    }
}
