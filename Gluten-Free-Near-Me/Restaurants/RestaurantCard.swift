//
//  RestaurantCard.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/27/24.
//

import SwiftUI

struct CardBody: View {
    let restaurant:Restaurant

    func LabelText() -> String {
        switch restaurant.ref {
        case .comments: return "Reviews Mention:";
        case .description: return "Self-Described as: "
        case .menu: return "Menu Items: "
        case .none: return ""
        }
    }
    
    var body : some View {
        Text(LabelText())
            .font(.title3)
            .foregroundColor(restaurant.getColor())
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
