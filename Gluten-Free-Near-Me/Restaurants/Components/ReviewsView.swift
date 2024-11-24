//
//  ReviewsView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/23/24.
//

import SwiftUI
import Foundation


// Ref: https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-advanced-text-styling-using-attributedstring
struct ReviewsView: View {
    let condensed:Bool
    var reviews:[Review] = []
    
    init(place:Restaurant, condensed:Bool = true) {
        self.condensed = condensed
        guard let reviews = place.reviews else { return }
        
        if (!condensed) { self.reviews = reviews; return  }
        self.reviews = reviews.map({
            Review(author: $0.author, body: condense(text: trim_newlines(text: $0.body)))
        })
    }
    
    let bold: [NSAttributedString.Key: Any] = [
        .foregroundColor: Color.text,
        .font: UIFont.boldSystemFont(ofSize: 36)
    ]
    
    func trim_newlines(text:String) -> String {
        return String(text.filter { char in
            !("\n\r".contains(char))
        })
    }
    
    func condense(text:String) -> String {
        // Condense a text into its mentioning of GF
        // https://developer.apple.com/documentation/swift/bidirectionalcollection/firstrange(of:)-1di7b
        if (!condensed) { return text }
        guard let matchRange = text.firstRange(of: GF_PATTERN) else {
            return text
        }
        
        // Bracket 20 characters around match
        var startIndex = matchRange.lowerBound.utf16Offset(in: text) - 20
        startIndex = max(0, startIndex)
        
        var endIndex = matchRange.upperBound.utf16Offset(in: text) + 20
        endIndex = min(text.count, endIndex)
        
        var start = text.index(text.startIndex, offsetBy: startIndex)
        
        // Continue backwards to nearest space (or start if we're in the middle of the first word)
        while (startIndex > 0 && String(text[start]) != " ") {
            startIndex -= 1
            start = text.index(text.startIndex, offsetBy: startIndex)
        }
        if (startIndex != 0) {
            start = text.index(text.startIndex, offsetBy: startIndex + 1)
        }
        
        let end = text.index(text.startIndex, offsetBy: endIndex)

        let leading_truncation = (0 < startIndex) ? "..." : ""
        let trailing_truncation = (endIndex < text.count) ? "..." : ""
        
        return leading_truncation + String(text[start..<end]) + trailing_truncation
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(reviews) { review in
                    Text(review.author).bold() + Text(" - \(review.body)")
                }
            }
        }
        .frame(maxHeight: (condensed) ? 50 : .infinity)
    }
}


struct PreviewReviews :  View {
    @StateObject var prefManager = PreferenceManager()
    @StateObject var resManager = RestaurantManager()
    
    var body : some View {
        ReviewsView(place: Restaurant.sample_place_1(), condensed: true)
            .environmentObject(prefManager)
            .environmentObject(resManager)
            .modelContainer(resManager.container)
    }
}

#Preview {
    PreviewReviews()
}
