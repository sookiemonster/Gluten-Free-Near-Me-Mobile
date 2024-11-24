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

struct CardHeader : View {
    let restaurant:Restaurant
    var body: some View {
        HStack{
            Text(restaurant.name)
                .font(.title2)
                .bold()
                .lineLimit(2)
                .truncationMode(.tail)
            Spacer()
            SaveButton(restaurant: restaurant)
            ShareButton(linkString: restaurant.googURI)
        }
    }
}

struct CardBody: View {
    @EnvironmentObject var prefManager:PreferenceManager
    let restaurant:Restaurant
    
    @ViewBuilder
    func renderLabel() -> some View {
        Text(restaurant.getBodyLabel())
            .font(.body)
            .foregroundColor(restaurant.getColor(prefManager: prefManager))
            .bold()
            .underline()
    }
    
    @ViewBuilder
    func renderDescription() -> some View {
        Text(restaurant.googDescription)
            .italic()
            .lineLimit(3)
            .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
    }
    
    var body : some View {
        renderLabel()
        Spacer().frame(height: 5)
        switch restaurant.ref {
        case .reviews: ReviewsView(place: restaurant)
        case .description : renderDescription()
        default: EmptyView()
        }
    }
}

struct RestaurantCard: View {
    let restaurant:Restaurant
    
    func getSquarePadding() -> CGFloat {
        // Cap padding at 10px or being responsive
        return max(30, min(UIScreen.main.bounds.height / 20, UIScreen.main.bounds.width / 20))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            CardHeader(restaurant: restaurant)
            RatingView(rating: restaurant.rating, size: 16)
            Spacer().frame(height: 15)
            CardBody(restaurant: restaurant)
        }
        .padding(getSquarePadding())
        .background()
        .cornerRadius(30)
    }
}


struct PreviewCard :  View {
    @StateObject var prefManager = PreferenceManager()
    @StateObject var resManager = RestaurantManager()
    
    var body : some View {
        RestaurantCard(restaurant: .sample_place_1())
            .environmentObject(prefManager)
            .environmentObject(resManager)
            .modelContainer(resManager.container)
    }
}

#Preview {
    ZStack {
        PreviewCard()
    }
    .fillParent()
    .background(.white)
}
