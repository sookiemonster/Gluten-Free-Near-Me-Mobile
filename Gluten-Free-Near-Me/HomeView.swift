//
//  HomeView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var showRestaurants = true;
    private var platform:UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    @Environment(\.modelContext) var modelContext;
    @EnvironmentObject var observer:RestaurantObserver
    
    // Reference: https://www.hackingwithswift.com/quick-start/swiftdata/how-to-use-query-to-read-swiftdata-objects-from-swiftui
    
    @Query(filter: #Predicate<Restaurant> { place in
//        place.isSaved
        true
    }) var savedRestaurants:[Restaurant];
    
    
    func addDebug() {
        let newres = Restaurant.sample_place_1
        modelContext.insert(newres)
    }
    
    var body: some View {
        ZStack {
            MapView()
            VStack() {
//                Button("RESET") {
//                    do  {
//                        try modelContext.delete(model: Restaurant.self)
//                    } catch {
//                        print("Failed to clear.")
//                    }
//                }.padding().background(.red).padding()
//                
//                Button("Add") {
//                    addDebug()
//                }.padding().background(.red).padding()
                
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
                    RestaurantStack(restaurants: savedRestaurants)
                }
            }.animation(.easeInOut(duration: 0.2), value: observer.isFocused())
        }
    }
}

#Preview {
    HomeView()
}
