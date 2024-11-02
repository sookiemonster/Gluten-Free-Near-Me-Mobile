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
    @StateObject var tabManager = TabManager()

    var body: some View {
        NavigationStack() {
            ZStack {
                HomeView()
                
                if (tabManager.selectedTab == .saved) {
                    SavedView()
                        .opaque()
                        .transition(.opacity)
                        .zIndex(3)
                }
                
                if (tabManager.selectedTab == .profile) {
                    SettingsView()
                }
            }
            .navigationToolbar()
        }
        .environmentObject(manager)
        .environmentObject(observer) 
        .environmentObject(tabManager)
    }
}

#Preview {
    MasterView()
}
