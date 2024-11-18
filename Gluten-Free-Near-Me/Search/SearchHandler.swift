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
            searches.async {
                Task {
                    await searchBy(center: viewportRegion.center)
                }
        }
    }
}

// https://www.swiftwithvincent.com/blog/how-to-write-your-first-api-call-in-swiftß
// https://curlconverter.com/swift/
func searchBy(center:CLLocationCoordinate2D) async -> Void {
    let API_KEY = "NOT GOING TO COMMIT"
    let jsonData = [
        "includedTypes": [
            "restaurant"
        ],
        "maxResultCount": 1,
        "locationRestriction": [
            "circle": [
                "center": [
                    "latitude": center.latitude,
                    "longitude": center.longitude
                ],
                "radius": 500
            ]
        ]
    ] as [String : Any]
    let data = try! JSONSerialization.data(withJSONObject: jsonData, options: [])

    let url = URL(string: "https://places.googleapis.com/v1/places:searchNearby")!
    let headers = [
        "Content-Type": "application/json",
        "X-Goog-Api-Key": API_KEY,
        "X-Goog-FieldMask": PlacesResponse.field_mask
    ]

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = data as Data
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error)
        } else if let data = data {
            let str = String(data: data, encoding: .utf8)
            print(str)
            do {
                let responseObject = try JSONDecoder().decode(PlacesResponse.self, from: data)
                extractRestaurants(response: responseObject)
                if let error = responseObject.error {
                    print(error.message)
                }
            } catch {
                print(error)
            }
        }
    }

    task.resume()
}

func extractRestaurants(response:PlacesResponse) -> [Restaurant] {
    guard let places = response.places else { return [] }
    
    let place = places[0]
    
    // Lookup in DB
    
    let construct = Restaurant(googURI: place.googleMapsUri, name: place.displayName.text, googDescription: place.editorialSummary.text, rating: place.rating, ref: .none, lat: place.location.latitude, lng: place.location.longitude)
    
    return []
}
