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
    
    // See: https://stackoverflow.com/questions/76781545/swift-async-awaiting-all-tasks-in-task-group
    
    func searchViewport(resManager:RestaurantManager, callback: @escaping () -> Void) -> Void {
        
        guard let viewportRegion = viewportRegion else { return ;}
        resManager.wipe_search()
        print(viewportRegion.center)
        
        let center_focus = viewportRegion.center
        
        let left_focus = CLLocationCoordinate2D(latitude: center_focus.latitude - 0.003, longitude: center_focus.longitude)

        let right_focus = CLLocationCoordinate2D(latitude: center_focus.latitude + 0.003, longitude: center_focus.longitude)
        
        Task {
            await withTaskGroup(of: Void.self) { group in
//                group.addTask{ await searchBy(center: left_focus, resManager: resManager, callback: callback) }
                group.addTask{ await searchBy(center: center_focus, resManager: resManager, callback: callback) }
//                group.addTask{ await searchBy(center: right_focus, resManager: resManager, callback: callback) }
            }
        }
    }
}

// https://www.swiftwithvincent.com/blog/how-to-write-your-first-api-call-in-swiftß
// https://curlconverter.com/swift/
//https://stackoverflow.com/questions/60803515/swift-5-how-to-read-variables-in-plist-files 
func searchBy(center:CLLocationCoordinate2D, resManager:RestaurantManager, callback: @escaping () -> Void) async -> Void {
    
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
                "radius": 300
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
    
    let fetchNearby = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error)
            return
        }
        guard let data = data else {return; }
//        let str = String(data: data, encoding: .utf8)
        do {
            let responseObject = try JSONDecoder().decode(PlacesResponse.self, from: data)
            if let error = responseObject.error {
                print(error.message)
                return
            }
            patchRestaurantModel(response: responseObject, resManager: resManager)
            DispatchQueue.main.async {
                callback()
            }
            print("finished patching")
        } catch {
            print(error)
        }
    }
    fetchNearby.resume()
}

func patchRestaurantModel(response:PlacesResponse, resManager:RestaurantManager) -> Void {
    guard let places = response.places else { return; }
    let found = places
        .map({rankRestaurant(placeInfo: $0)})
        .filter({$0.ref != .none})
    let saved = resManager.getSaved()
    
    for to_add in found {
        if let pre_existing = saved.first(where: {$0.googURI == to_add.googURI}) {
            resManager.considerCurrentSearch(googUri: pre_existing.googURI)
        } else {
            print("attempting add: ", to_add.name)
            to_add.isCurrentSearch = true
            resManager.add(restaurant: to_add)
        }
    }
}
