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
    
    func searchViewport() async -> Void {
        
        guard let viewportRegion = viewportRegion else { return ;}
        print(viewportRegion.center)
        let searches = DispatchQueue(label: "searches")
        for index in (1...10) {
            searches.async {
                Task {
                    await searchBy(center: viewportRegion.center, test:index)
                }
            }
            
        }
    }
}

//https://www.swiftwithvincent.com/blog/how-to-write-your-first-api-call-in-swiftß
func searchBy(center:CLLocationCoordinate2D, test:Int) async -> Void {
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(test)")!

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PlacesResponse.self, from: data)
        print(decoded.id, decoded.name)
    } catch {
        print("err")
    }

//    return decoded.results
}
