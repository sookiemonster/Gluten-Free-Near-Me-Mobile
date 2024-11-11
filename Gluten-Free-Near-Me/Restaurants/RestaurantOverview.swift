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
            SaveButton(restaurant: restaurant)
        }.padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(restaurant.getColor(prefManager: prefManager))
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
            Text(restaurant.googDescription)
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
