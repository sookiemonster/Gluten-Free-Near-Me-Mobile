//
//  RestaurantCard.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/27/24.
//

import SwiftUI

extension Text {
    func quotation() -> some View {
        // Add quotation marks via the computed style (because quotes detract from code readability)
        return Text("\"\(self)\"")
    }
}

struct CardBody: View {
    let restaurant:Restaurant
    
    @ViewBuilder
    func reviewList() -> some View {
        VStack {
            ForEach(restaurant.reviews ?? []) { review in
                HStack(spacing: 0) { Text(review.author + " - ").bold(); Text(review.body).quotation() }
            }
        }
    }
    
    var body : some View {
        Text(restaurant.getBodyLabel())
            .font(.body)
            .foregroundColor(restaurant.getColor())
            .bold()
            .underline()
        Spacer().frame(height: 5)
        switch restaurant.ref {
        case .reviews: reviewList()
        default: EmptyView()
        }
    }
}

struct RestaurantCard: View {
    let restaurant:Restaurant
    
    func getSquarePadding() -> CGFloat {
        // Cap padding at 10px or being responsive
        return max(10, min(UIScreen.main.bounds.height / 30, UIScreen.main.bounds.width / 30))
    }

    var body: some View {
        VStack(alignment: .leading) {
            CardHeader(restaurant: restaurant)
            Ratings(rating: restaurant.rating)
            Spacer().frame(height: 20)
            CardBody(restaurant: restaurant)
        }
        .padding(getSquarePadding())
        .background()
        .cornerRadius(15)
    }
}

#Preview {
    ZStack {
        RestaurantCard(restaurant: .sample_place_1)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.red)
}

struct CardHeader : View {
    let restaurant:Restaurant
    var body: some View {
        HStack {
            Text(restaurant.name)
                .font(.title)
                .bold()
            Spacer()
            SaveButton(saved: restaurant.isSaved)
            Text("Sh")
        }
    }
}

struct Ratings: View {
    let rating:Double;
    var body: some View {
        Text("RATINGS")
    }
}
