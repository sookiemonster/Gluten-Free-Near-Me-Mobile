//
//  HomeView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var restaurantSheetController = SheetController()
    
    @Environment(\.modelContext) var modelContext;
    @EnvironmentObject var observer:RestaurantObserver
    
    // Reference: https://www.hackingwithswift.com/quick-start/swiftdata/how-to-use-query-to-read-swiftdata-objects-from-swiftui
    
    @Query(filter: #Predicate<Restaurant> { place in
        place.isCurrentSearch
    }) var savedRestaurants:[Restaurant];

    
    var body: some View {
        ZStack {
            MapView()
            VStack() {
                if (observer.isFocused()) {
                    RestaurantCard(restaurant: observer.selected!)
                        .padding()
                        .transition(.opacity.combined(with: .move(edge: .leading)))
                } else {
                    if (restaurantSheetController.isVisible()) {
                        Spacer()
                    }
                    SearchButton()
                        .padding()
                        .animation(.easeInOut(duration: 0.2), value: observer.isFocused())
                }
                Spacer()
                PositionalSheet(controller: _restaurantSheetController) {
                    RestaurantStack(restaurants: savedRestaurants)
                }
            }.animation(.easeInOut(duration: 0.2), value: observer.isFocused())
        }
        .environmentObject(restaurantSheetController)
    }
}

#Preview {
    HomeView()
}
