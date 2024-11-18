//
//  RestaurantMarker.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/1/24.
//

import SwiftUI

struct RestaurantMarker: View {
    let restaurant:Restaurant
    let prefManager:PreferenceManager
    
    var body: some View {
        Image(systemName: "fork.knife.circle.fill")
            .renderingMode(.template)
            .foregroundStyle(restaurant.getColor(prefManager: prefManager),.text)
            .font(.title)
            .padding(5)
            .overlay {
                if (restaurant.isSaved) {
                    Image(systemName: "heart.circle.fill")
                        .renderingMode(.template)
                        .foregroundStyle(.text, restaurant.getColor(prefManager: prefManager))
                        .font(.subheadline)
                        .offset(x: 12, y: -13)
                } 
            }
    }
}

