//
//  RestaurantStore.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/26/24.
//

import Foundation
import MapKit
import SwiftUI
import SwiftData

enum Mentioner : Int8, Codable {
    case none = 0
    case reviews = 1
    case menu = 2
    case description = 3
}

struct Item {
    var name:String
}

struct Review : Identifiable, Codable {
    var id = UUID()
    let author:String
    let body:String
}

@Model
class Restaurant : Identifiable, Hashable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.googURI == rhs.googURI
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(googURI)
    }
    
    init(googURI:String, name:String, googDescription:String, rating:Double, ref:Mentioner, reviews:[Review] = [], lat:Double, lng:Double, link:String = "") {
        self.googURI = googURI
        self.name = name
        self.lat = lat
        self.lng = lng
        self.googDescription = googDescription
        self.isSaved = false
        self.rating = rating
        self.ref = ref
        self.reviews = reviews
        self.link = link
        self.id = UUID()
    }
    
    func loc() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
    }
    
    let id:UUID
    let googURI:String
    let lat:Double
    let lng:Double
    let name:String
    let googDescription:String
    let rating: Double
    let ref:Mentioner
    let link:String
    var reviews:[Review]?
    var isSaved:Bool
}

extension Restaurant {
    func getColor(prefManager:PreferenceManager) -> Color {
        switch (ref) {
        case .reviews: return prefManager.reviewColor
        case .description: return prefManager.descriptionColor
        case .menu: return prefManager.menuColor
        default: return Color(.black)
        }
    }
    
    func getBodyLabel() -> String {
        switch ref {
        case .reviews: return "Reviews Mention GF:";
        case .description: return "Self-Described as GF: "
        case .menu: return "Menu Items: "
        case .none: return ""
        }
    }
}

struct RestaurantStore {
    var saved:[Restaurant]
    var searchResults:[Restaurant]
}


extension Restaurant {
    static let sample_place_1 = Restaurant(
        googURI: "idawdw", name: "Pizza Hut", googDescription: "Some description", rating: 4.5, ref: Mentioner.reviews, reviews: [
            Review(author: "The Hut", body: "Yeah lol it ain't gluten free."),
            Review(author: "Someone2", body: "Yeah lol it ain't gluten free."),
            Review(author: "Some3", body: "Yeah lol it ain't gluten free."),
            Review(author: "Somen4", body: "Yeah lol it ain't gluten free.")
                 ], lat: 40.70, lng: -73.87
    )
    
//    static let sample_place_2 = Restaurant(
//        loc: CLLocationCoordinate2D(latitude: 40.7054, longitude: -73.865),
//        name: "Mama Jones",
//        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//        rating: 4.5,
//        ref: .description,
//        isSaved: false
//    )
//    static let sample_place_3 = Restaurant(
//        loc: CLLocationCoordinate2D(latitude: 40.705, longitude: -73.868),
//        name: "Wendys",
//        description: "Another fictional demo-description",
//        rating: 4.5,
//        ref: .reviews,
//        isSaved: false
//    )
//    static let sample_place_4 = Restaurant(
//        loc: CLLocationCoordinate2D(latitude: 40.707, longitude: -73.865),
//        name: "SomeWhere",
//        description: "Another fictional demo-description",
//        rating: 4.5,
//        ref: .description,
//        isSaved: false
//    )
//    static let sample_place_5 = Restaurant(
//        loc: CLLocationCoordinate2D(latitude: 40.705, longitude: -73.865),
//        name: "Bakery",
//        description: "Another fictional demo-description",
//        rating: 4.5,
//        ref: .reviews,
//        isSaved: false
//    )
//    static let sample_place_6 = Restaurant(
//        loc: CLLocationCoordinate2D(latitude: 40.705, longitude: -73.863),
//        name: "Daniel's Deli",
//        description: "Another fictional demo-description",
//        rating: 4.5,
//        ref: .description,
//        isSaved: false
//    )
}

extension RestaurantStore {
    static let sample_places:[Restaurant] = [
//        Restaurant.sample_place_1
//        Restaurant.sample_place_2,
//        Restaurant.sample_place_3,
//        Restaurant.sample_place_4,
//        Restaurant.sample_place_5,
//        Restaurant.sample_place_6
    ]
}
