//
//  RestaurantStore.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/26/24.
//

import Foundation
import MapKit

enum Mentioner : Int8 {
    case none = 0
    case comments = 1
    case menu = 2
    case description = 3
}

struct Item {
    var name:String
}

struct Restaurant {
//    var id:UUID
//    var id:UUID
    var loc:CLLocationCoordinate2D
    var name:String
    var description:String
    var rating: Double
    var ref:Mentioner
    var items:[Item]?
    var isSaved:Bool
}

struct RestaurantStore {
    var saved:[Restaurant]
    var searchResults:[Restaurant]
}


extension Restaurant {
    static let somePlace = Restaurant( loc: CLLocationCoordinate2D(latitude: 40.70, longitude: -73.87), name: "Pizza Hut", description: "Not actually gluten free. lol", rating: 4.5, ref: .comments, isSaved: false)
}
