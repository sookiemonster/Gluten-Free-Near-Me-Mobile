//
//  SavedView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/1/24.
//

import SwiftUI
import SwiftData

struct SavedHeader: View {
    @Binding var detailMode:DrillDownMode;
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Saved Restaurants")
                .font(.largeTitle)
                .bold()
            DrillDownSelector(selected: $detailMode)
        }.fillWidth(alignment: .leading)
    }
}

struct SavedView: View {
    @State private var detailMode:DrillDownMode = .compact;
    @Environment(\.modelContext) var modelContext;
    
    @Query(filter: #Predicate<Restaurant> { place in
        place.isSaved
    }) var savedRestaurants:[Restaurant];
    
    var body: some View {
        VStack(spacing: 20) {
            SavedHeader(detailMode: $detailMode)
            RestaurantStack(restaurants: savedRestaurants, mode: $detailMode, showUnsaved: false)
        }
        .padding(20)
        .fillParent()
    }
}

#Preview {
    SavedView()
}
