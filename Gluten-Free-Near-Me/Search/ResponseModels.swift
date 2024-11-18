//
//  ResponseModels.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/13/24.
//

struct PlacesResponse : Decodable {
    let places:[Place]?
    let error:Error?
}

struct Error: Decodable {
    let code:Int
    let message:String
}

struct TextContainer : Decodable {
    var text:String = ""
}

struct Point : Decodable {
    let latitude:Double
    let longitude:Double
}

struct Author :Decodable {
    let displayName:String
}

struct ReviewResponse : Decodable {
    let text:TextContainer
    let authorAttribution:Author
}

struct Summary : Decodable {
    let overview:TextContainer?
    let description:TextContainer?
}

struct Place : Decodable {
    let displayName:TextContainer   // Display name
    let id:String              // Google Maps Place Id
    let googleMapsUri:String        // Google Maps Link
    let rating:Double               // Rating of the restaurant
    let location:Point              // Location of restaurant
    let editorialSummary:TextContainer?        // Basic summary
    var reviews:[ReviewResponse] = []               // Reviews
    let generativeSummary:Summary?             // Generative summary
}

extension PlacesResponse {
    static let field_mask =
        "places.displayName,places.id,places.googleMapsUri,places.rating,places.location,places.editorialSummary,places.reviews,places.generativeSummary"
}
