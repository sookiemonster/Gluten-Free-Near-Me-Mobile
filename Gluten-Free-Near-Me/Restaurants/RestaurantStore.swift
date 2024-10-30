//
//  RestaurantStore.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/26/24.
//

import Foundation
import MapKit
import SwiftUI

enum Mentioner : Int8 {
    case none = 0
    case reviews = 1
    case menu = 2
    case description = 3
}

struct Item {
    var name:String
}

struct Review : Identifiable {
    let id = UUID()
    let author:String
    let body:String
}

struct Restaurant : Identifiable {
    let id = UUID()
    let loc:CLLocationCoordinate2D
    let name:String
    let description:String
    let rating: Double
    let ref:Mentioner
//    var items:[Item]?
    var reviews:[Review]?
    var isSaved:Bool
    
    func getColor() -> Color {
        switch (ref) {
        case .reviews: return Color(.yellow)
        case .description: return Color(.blue)
        case .menu: return Color(.green)
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
        loc: CLLocationCoordinate2D(latitude: 40.70, longitude: -73.87),
        name: "Pizza Hut",
        description: "Not actually gluten free. lol",
        rating: 4.5,
        ref: .reviews,
        reviews: [
            Review(author: "The Hut", body: "Yeah lol it ain't gluten free."),
            Review(author: "Someone2", body: "Yeah lol it ain't gluten free."),
            Review(author: "Some3", body: "Yeah lol it ain't gluten free."),
            Review(author: "Somen4", body: "Yeah lol it ain't gluten free.")
                 ],
        isSaved: false
    )
    static let sample_place_2 = Restaurant(
        loc: CLLocationCoordinate2D(latitude: 40.705, longitude: -73.865),
        name: "Mama Jones",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        rating: 4.5,
        ref: .description,
        isSaved: false
    )
    static let sample_place_3 = Restaurant(
        loc: CLLocationCoordinate2D(latitude: 40.705, longitude: -73.865),
        name: "Wendys",
        description: "Another fictional demo-description",
        rating: 4.5,
        ref: .reviews,
        isSaved: false
    )
    static let sample_place_4 = Restaurant(
        loc: CLLocationCoordinate2D(latitude: 40.705, longitude: -73.865),
        name: "SomeWhere",
        description: "Another fictional demo-description",
        rating: 4.5,
        ref: .description,
        isSaved: false
    )
    static let sample_place_5 = Restaurant(
        loc: CLLocationCoordinate2D(latitude: 40.705, longitude: -73.865),
        name: "Bakery",
        description: "Another fictional demo-description",
        rating: 4.5,
        ref: .reviews,
        isSaved: false
    )
    static let sample_place_6 = Restaurant(
        loc: CLLocationCoordinate2D(latitude: 40.705, longitude: -73.865),
        name: "Daniel's Deli",
        description: "Another fictional demo-description",
        rating: 4.5,
        ref: .description,
        isSaved: false
    )
}

extension RestaurantStore {
    static let sample_places = [
        Restaurant.sample_place_1,
        Restaurant.sample_place_2,
        Restaurant.sample_place_3,
        Restaurant.sample_place_4,
        Restaurant.sample_place_5,
        Restaurant.sample_place_6]
}
