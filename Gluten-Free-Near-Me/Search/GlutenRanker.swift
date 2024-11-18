//
//  GlutenRanker.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/17/24.
//

import Foundation

// See https://developer.apple.com/documentation/swift/regex
let GF_PATTERN = /\bGF\b|gluten[^a-zA-Z0-9]free\b|celiac\b/

func rankRestaurant(placeInfo:Place) -> Restaurant {
    let editorialSummary = placeInfo.editorialSummary?.text ?? " "
    let generativeShort = placeInfo.generativeSummary?.overview?.text ?? ""
    let generativeLong = placeInfo.generativeSummary?.description?.text ?? ""
    
    let construct = Restaurant(googURI: placeInfo.googleMapsUri, name: placeInfo.displayName.text, googDescription: editorialSummary, rating: (placeInfo.rating ?? -1), ref: .none, lat: placeInfo.location.latitude, lng: placeInfo.location.longitude)
    
    // Check summaries for GF
    if (editorialSummary.contains(GF_PATTERN)) {
        construct.ref = .description
    } else if (generativeShort.contains(GF_PATTERN)) {
        construct.ref = .description
        construct.googDescription = generativeShort;
    } else if (generativeLong.contains(GF_PATTERN)) {
        construct.ref = .description
        construct.googDescription = generativeLong
    }
    
    if (construct.ref != .none) { return construct }
    
    // Check reviews
    let filtered = filterGFReviews(reviews: placeInfo.reviews)
    if (filtered.count > 0) {
        construct.ref = .reviews
        construct.reviews = filtered
    }
    
    return construct
}

func filterGFReviews(reviews:[ReviewResponse]?) -> [Review] {
    guard let reviews = reviews else { return [] }
    
    return reviews
        .filter({ ($0.text?.text ?? "").contains(GF_PATTERN)})
        .map({
            Review(author: $0.authorAttribution?.displayName ?? "Anonymous", body: $0.text?.text ?? "")
        })
}
