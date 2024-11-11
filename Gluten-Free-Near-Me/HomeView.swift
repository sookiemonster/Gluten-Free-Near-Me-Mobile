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
        ZStack {
            MapView()
            VStack() {
                if (observer.isFocused()) {
                    RestaurantCard(restaurant: observer.selected!)
                        .padding()
                        .transition(.opacity.combined(with: .move(edge: .leading)))
                } else {
                    Spacer()
                    SearchButton()
                        .padding()
                        .animation(.easeInOut(duration: 0.2), value: observer.isFocused())
                }
                Spacer()
                PositionalSheet() {
                    RestaurantStack(restaurants: RestaurantStore.sample_places)
                }
            }.animation(.easeInOut(duration: 0.2), value: observer.isFocused())
        }
    }
}

#Preview {
    HomeView()
}
