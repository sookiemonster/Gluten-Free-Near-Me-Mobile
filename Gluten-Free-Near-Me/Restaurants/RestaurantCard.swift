//
//  RestaurantCard.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/27/24.
//

import SwiftUI

extension Text {
    func quotation() -> some View {
        // Add quotation marks to text (because quotes detract from code readability) & italicize
        return Text("\"\(self)\"").italic()
    }
}

struct CardBody: View {
    let restaurant:Restaurant
    
    @ViewBuilder
    func renderLabel() -> some View {
        Text(restaurant.getBodyLabel())
            .font(.body)
            .foregroundColor(restaurant.getColor())
            .bold()
            .underline()
    }
    
    @ViewBuilder
    func renderReviews() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(restaurant.reviews ?? []) { review in
                    HStack(spacing: 0) { Text(review.author + " - ").bold(); Text(review.body).quotation() }
                }
            }
        }
        .frame(maxHeight: 40)
    }
    
    @ViewBuilder
    func renderDescription() -> some View {
        Text(restaurant.description).quotation()
    }
    
    var body : some View {
        renderLabel()
        Spacer().frame(height: 5)
        switch restaurant.ref {
        case .reviews: renderReviews()
        case .description : renderDescription()
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
        RestaurantCard(restaurant: .sample_place_2)
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
            ShareButton(link: URL(string:"https:://ibm.com"))
        }
    }
}

struct Ratings: View {
    let rating:Double;
    var body: some View {
        Text("RATINGS")
    }
}

struct ShareButton: View {
    let link:URL?
    
    var body : some View {
        if let href = link {
            Button {
                // share link, or prompt to open on GGL maps
            } label: {
                Image(systemName: "square.and.arrow.up").font(.title)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
        }
    }
}
