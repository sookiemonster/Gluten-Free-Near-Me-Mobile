//
//  RestaurantList.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct RestaurantStack: View {
    @EnvironmentObject var manager:LocationManager;
    
    @Binding var mode:DrillDownMode;
    let restaurants:[Restaurant];
    
    init(restaurants:[Restaurant], mode:Binding<DrillDownMode> = .constant(.compact)) {
        self.restaurants = restaurants
        self._mode = mode
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(restaurants) { place in
                    switch mode {
                    case .compact:
                        RestaurantOverview(restaurant: place)
                            .transition(.slide)
          
                    case .expanded:
                        RestaurantCard(restaurant: place)
                            .transition(.opacity)
                    }
                }
            }
        }
    }
}

#Preview {
    RestaurantStack(restaurants: RestaurantStore.sample_places)
}
