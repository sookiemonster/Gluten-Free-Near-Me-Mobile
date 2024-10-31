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
    
    func onPad() -> Bool { return platform == .pad }
    func onPhone() -> Bool { return platform == .phone }
    
    var body: some View {
        ZStack {
            ZStack {
                MapView()
                VStack() {
                    if (!showRestaurants) { Spacer() }
                    SearchButton()
                        .padding()
                    if (showRestaurants && onPad()) {
                        Spacer()
                        RestaurantStack(restaurants: RestaurantStore.sample_places)
                            .frame(maxHeight: UIScreen.main.bounds.height / 3)
                    }
                    if (showRestaurants && onPhone()) { Spacer() }
                }
            }
            if (onPhone()) {
                ZStack{}.sheet(isPresented: $showRestaurants) {
                RestaurantStack(restaurants: RestaurantStore.sample_places)
                    .presentationDetents([.fraction(0.2), .fraction(0.6)])
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
