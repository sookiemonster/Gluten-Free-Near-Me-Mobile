//
//  PlaceOverview.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct RestaurantOverview: View {
    let restaurant:Restaurant
    
    var body: some View {
        HStack {
            Briefing(restaurant: restaurant)
            Spacer()
            SaveButton(saved: restaurant.isSaved)
        }.padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(restaurant.getColor())
        .cornerRadius(10)
    }
}

struct Briefing: View {
    let restaurant:Restaurant
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(restaurant.name)
                .font(.title3)
                .fontWeight(.bold)
            Text(restaurant.description)
                .font(.subheadline)
        }
        .onTapGesture {
            // pan on map
            // open restaurant card
        }
    }
}

#Preview {
    RestaurantOverview(restaurant: .sample_place_1)
        .frame(maxWidth: .infinity).padding()
}
