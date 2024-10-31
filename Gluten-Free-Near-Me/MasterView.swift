//
//  ContentView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct MasterView: View {
    @StateObject var manager = LocationManager()
    @StateObject var observer = RestaurantObserver()

    var body: some View {
        TabView() {
            HomeView()
        }.environmentObject(manager)
        .environmentObject(observer)
        
    }
}

#Preview {
    MasterView()
}
