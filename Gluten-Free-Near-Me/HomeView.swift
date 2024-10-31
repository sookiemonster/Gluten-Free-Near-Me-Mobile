//
//  HomeView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showRestaurants = true;
    private var platform:UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    @EnvironmentObject var observer:RestaurantObserver
    
    func onPad() -> Bool { return platform == .pad }
    func onPhone() -> Bool { return platform == .phone }
    
    var body: some View {
        if (onPad()) {
            ZStack {
                MapView()
                VStack {
                    if (!showRestaurants) { Spacer() }
                    SearchButton().padding()
                    
                    if (observer.isFocused()) {
                        RestaurantCard(restaurant: .sample_place_1)
                            .padding()
                    }
                    
                    if (showRestaurants) {
                        Spacer()
                        RestaurantStack(restaurants: RestaurantStore.sample_places)
                            .frame(maxHeight: UIScreen.main.bounds.height / 3)
                    }
                }
            }
        } else if (onPhone()) {
            ZStack {
                MapView()
                VStack() {
                    if (observer.isFocused()) {
                        RestaurantCard(restaurant: observer.selected!)
                            .padding()
                            .transition(.opacity.combined(with: .move(edge: .leading)))
                    }
                    Spacer()
                    SearchButton()
                        .padding()
                }.animation(.easeInOut(duration: 0.2), value: observer.isFocused())
            }
            .sheet(isPresented: $showRestaurants) {
                RestaurantStack(restaurants: RestaurantStore.sample_places)
                    .presentationDetents([.fraction(0.01), .fraction(0.2), .fraction(0.6)])
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
            }
        }
    }
}

#Preview {
    HomeView()
}
