//
//  HomeView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showRestaurants = true;
    var body: some View {
        ZStack {
            MapView()
            VStack() {
                Spacer()
                SearchButton()
                    .padding()
//                RestaurantStack(restaurants: RestaurantStore.sample_places)
            }
        }.sheet(isPresented: $showRestaurants) {
            RestaurantStack(restaurants: RestaurantStore.sample_places)
                .padding([.top], 5)
                .presentationDetents([.fraction(0.2), .fraction(0.6)])
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled()
        }
        
    }
}

#Preview {
    HomeView()
}
