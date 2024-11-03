//
//  PlaceOverview.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct RestaurantOverview: View {
    @EnvironmentObject var prefManager:PreferenceManager
    let restaurant:Restaurant
    
    var body: some View {
            
        HStack (spacing: 15) {
            Briefing(restaurant: restaurant)
            Spacer()
            ViewButton(restaurant: restaurant)
            SaveButton(name: restaurant.name, saved: restaurant.isSaved)
        }.padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .cornerRadius(10)
        .background(restaurant.getColor(prefManager: prefManager))
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
                .lineLimit(2)
                .truncationMode(.tail)
        }
    }
}

#Preview {
    RestaurantOverview(restaurant: .sample_place_1)
        .frame(maxWidth: .infinity).padding()
}
