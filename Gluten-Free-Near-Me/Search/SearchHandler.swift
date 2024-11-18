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
    
    func searchViewport(resManager:RestaurantManager) async -> Void {
        
        guard let viewportRegion = viewportRegion else { return ;}
        print(viewportRegion.center)
        let searches = DispatchQueue(label: "searches")
            searches.async {
                Task {
                    await searchBy(center: viewportRegion.center, resManager: resManager)
                }
        }
    }
}

// https://www.swiftwithvincent.com/blog/how-to-write-your-first-api-call-in-swiftß
// https://curlconverter.com/swift/
//https://stackoverflow.com/questions/60803515/swift-5-how-to-read-variables-in-plist-files 
func searchBy(center:CLLocationCoordinate2D, resManager:RestaurantManager) async -> Void {
    
    var API_KEY = ""
    guard let api_url = Bundle.main.url(forResource: "key", withExtension: "plist") else { return; }
    
    do {
        let key_data = try Data(contentsOf: api_url)
        let decoded = try PropertyListDecoder().decode(KeyContainer.self, from: key_data)
        API_KEY = decoded.value
    } catch {
        print(error)
        print("Could not access API key.")
        return;
    }
    
    let jsonData = [
        "includedTypes": [
            "restaurant"
        ],
        "maxResultCount": 20,
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
                if let error = responseObject.error {
                    print(error.message)
                    return
                }
                patchRestaurantModel(response: responseObject, resManager: resManager)
                print("finished patchng")
            } catch {
                print(error)
            }
        }
    }

    task.resume()
}

func patchRestaurantModel(response:PlacesResponse, resManager:RestaurantManager) -> Void {
    guard let places = response.places else { return }
    let found = places.map({rankRestaurant(placeInfo: $0)})
    let saved = resManager.getSaved()
    
    for to_add in found {
        if let pre_existing = saved.first(where: {$0.googURI == to_add.googURI}) {
            print("exists")
        } else {
            print("attempting add: ", to_add.name)
            resManager.add(restaurant: to_add)
        }
    }
}
