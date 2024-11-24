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
    let reviews:[Review]
    
    init(place:Restaurant) {
        guard let reviews = place.reviews else {
            self.reviews = []
            return
        }
        self.reviews = reviews
    }
    
    let bold: [NSAttributedString.Key: Any] = [
        .foregroundColor: Color.text,
        .font: UIFont.boldSystemFont(ofSize: 36)
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(reviews) { review in
                    Text(review.author).bold() + Text(" - \(review.body)")
                }
            }
        }
        .frame(maxHeight: 50)
    }
}


struct PreviewReviews :  View {
    @StateObject var prefManager = PreferenceManager()
    @StateObject var resManager = RestaurantManager()
    
    var body : some View {
        ReviewsView(place: Restaurant.sample_place_1())
            .environmentObject(prefManager)
            .environmentObject(resManager)
            .modelContainer(resManager.container)
    }
}

#Preview {
    PreviewReviews()
}
