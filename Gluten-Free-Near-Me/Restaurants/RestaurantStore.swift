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
    
    init(googURI:String, name:String, googDescription:String, rating:Double, ref:Mentioner, reviews:[Review] = [], lat:Double, lng:Double) {
        self.googURI = googURI
        self.name = name
        self.lat = lat
        self.lng = lng
        self.googDescription = googDescription
        self.isSaved = false
        self.rating = rating
        self.ref = ref
        self.reviews = reviews
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
    var reviews:[Review]?
    var isSaved:Bool
    var isCurrentSearch = false;
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
    
    func getHeader() -> String {
        switch ref {
        case .reviews: return "Reviews Mention GF";
        case .description: return "Description Mentions GF"
        case .menu: return "Menu Contains Gluten-Free Items"
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
        ], lat: 40.70, lng: -73.87
        )
    }
}

// See: https://blog.jacobstechtavern.com/p/swiftdata-outside-swiftui


class RestaurantStore {
    var container: ModelContainer
    
    init() throws {
        self.container = try ModelContainer(for: Restaurant.self)
    }
    
    func select(googUri:String) throws -> Restaurant? {
        let context = ModelContext(container)
        let fetchId = FetchDescriptor<Restaurant> (predicate:
            #Predicate { res in
                res.googURI == googUri
            }
        )
        
        let found = try context.fetch(fetchId)
        return found.isEmpty ? nil : found[0];
    }
    
    func add_if_not_exists(restaurant:Restaurant) throws -> Void {
        if try select(googUri: restaurant.googURI) != nil { return }
        
        let context = ModelContext(container)
        context.insert(restaurant)
        try context.save()
    }
    
    func selectSaved() throws -> [Restaurant] {
        let context = ModelContext(container)
        let fetchId = FetchDescriptor<Restaurant> (predicate:
            #Predicate { res in
                res.isSaved
            }
        )
        
        return try context.fetch(fetchId)
    }
    
    func clear_unsaved() throws -> Void {
        let context = ModelContext(container)
        try context.delete(model: Restaurant.self, where: #Predicate {
            !$0.isSaved
        })
    }
    
    func wipe_search() throws -> Void {
        let context = ModelContext(container)
        let fetchPreviousSearch = FetchDescriptor<Restaurant> (predicate:
            #Predicate { res in
                res.isCurrentSearch
            }
        )
        
        let staleResults = try context.fetch(fetchPreviousSearch)
        for restaurant in staleResults {
            print(restaurant.name)
            restaurant.isCurrentSearch = false
        }
        
        try context.save()
    }
    
    func flagCurrent(googUri:String) throws {
        let context = ModelContext(container)
        let fetchId = FetchDescriptor<Restaurant> (predicate:
            #Predicate { res in
                res.googURI == googUri
            }
        )
        
        let found = try context.fetch(fetchId)
        if (found.isEmpty) { return; }
        
        found[0].isCurrentSearch = true
        try context.save()
    }
}

class RestaurantManager : ObservableObject {
    let database: RestaurantStore
    let container: ModelContainer

    init() {
        self.database = try! RestaurantStore()
        self.container = database.container
        
        wipe_search()
    }
    
    func getSaved() -> [Restaurant] {
        do {
            return try database.selectSaved()
        } catch {
            return []
        }
    }
    
    func add(restaurant:Restaurant) {
        do {
            try database.add_if_not_exists(restaurant: restaurant)
            print("successful add.")
        } catch { print("failed to add") }
    }
    
    func clear_unsaved() {
        do { try database.clear_unsaved() }
        catch { print("could not delete items") }
    }
    
    func wipe_search() {
        do { try database.wipe_search() }
        catch { print("could not wipe search results") }
    }
    
    func considerCurrentSearch(googUri:String) {
        do { try database.flagCurrent(googUri: googUri); }
        catch { print("could not flag id \(googUri) as current.")}
    }
}
