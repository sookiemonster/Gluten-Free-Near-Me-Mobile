//
//  ResponseModels.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/13/24.
//

struct PlacesResponse : Decodable {
    let places:[Place]
}

struct TextContainer : Decodable {
    let text:String
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
    let overview:TextContainer
    let description:TextContainer
}

struct Place : Decodable {
    let displayName:TextContainer   // Display name
    let placeId:String              // Google Maps Place Id
    let googleMapsUri:String        // Google Maps Link
    let rating:Double               // Rating of the restaurant
    let location:Point              // Location of restaurant
    let editorialSummary:TextContainer        // Basic summary
    let reviews:[ReviewResponse]              // Reviews
    let generativeSummary:Summary             // Generative summary
    
}
