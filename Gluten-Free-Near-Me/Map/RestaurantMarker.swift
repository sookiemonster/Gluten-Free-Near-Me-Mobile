//
//  RestaurantMarker.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/1/24.
//

import SwiftUI

struct RestaurantMarker: View {
    let restaurant:Restaurant
    var body: some View {
        Image(systemName: "fork.knife.circle.fill")
            .renderingMode(.template)
            .foregroundStyle(restaurant.getColor(),.text)
            .font(.title)
            .padding(5)
    }
}

#Preview {
    RestaurantMarker(restaurant: .sample_place_1)
}
