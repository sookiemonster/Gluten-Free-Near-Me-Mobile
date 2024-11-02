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
    @State var tab:Tab = .home

    var body: some View {
        NavigationStack() {
            ZStack {
                HomeView()
                
                if (tab == .saved) {
                    SavedView()
                        .opaque()
                        .transition(.opacity)
                        .zIndex(3)
                }
                
                if (tab == .profile) {
                    SettingsView()
                }
            }
            .navigationToolbar(tab: $tab)
        }
        .environmentObject(manager)
        .environmentObject(observer) 
    }
}

#Preview {
    MasterView()
}
