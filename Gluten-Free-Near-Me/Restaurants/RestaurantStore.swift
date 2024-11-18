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
    @Attribute(.unique) let googURI:String
    let lat:Double
    let lng:Double
    let name:String
    var googDescription:String
    let rating: Double
    var ref:Mentioner
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


extension Restaurant {
    static func sample_place_1() -> Restaurant {
        return Restaurant (googURI: "idawdw", name: "Pizza Hut", googDescription: "Some description", rating: 4.5, ref: Mentioner.reviews, reviews: [
            Review(author: "The Hut", body: "Yeah lol it ain't gluten free."),
            Review(author: "Someone2", body: "Yeah lol it ain't gluten free."),
            Review(author: "Some3", body: "Yeah lol it ain't gluten free."),
            Review(author: "Somen4", body: "Yeah lol it ain't gluten free.")
        ], lat: 40.70, lng: -73.87, link: "https://pizzahut.com"
        )
    }
}
