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
    let showUnsaved:Bool;
    
    init(restaurants:[Restaurant], mode:Binding<DrillDownMode> = .constant(.compact), showUnsaved:Bool = true) {
        print("INITING STACK")
        self.restaurants = restaurants
        self._mode = mode
        self.showUnsaved = showUnsaved
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(restaurants) { place in
                    if (showUnsaved || place.isSaved) {
                        switch mode {
                        case .compact:
                            RestaurantOverview(restaurant: place)
                                .transition(.slide.combined(with: .opacity))
                            
                        case .expanded:
                            RestaurantCard(restaurant: place)
                                .transition(.opacity)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RestaurantStack(restaurants: RestaurantStore.sample_places)
}
