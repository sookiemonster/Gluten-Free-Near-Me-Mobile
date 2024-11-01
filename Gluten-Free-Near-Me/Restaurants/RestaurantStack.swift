//
//  RestaurantList.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

enum ViewMode {
    case compact
    case expanded
}

struct RestaurantStack: View {
    @State private var mode:ViewMode = .compact
    @EnvironmentObject var manager:LocationManager;
    let restaurants:[Restaurant];
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(restaurants) { place in
                    switch mode {
                    case .compact:
                        RestaurantOverview(restaurant: place)
                    case .expanded:
                        RestaurantCard(restaurant: place)
                    }
                }
            }
        }
        .padding()
        .background()
    }
}

#Preview {
    RestaurantStack(restaurants: RestaurantStore.sample_places)
        .frame(width: UIScreen.main.bounds.width / 2)
        .frame(height: UIScreen.main.bounds.height / 4)
        .background(.gray)
}
