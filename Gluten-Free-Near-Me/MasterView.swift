//
//  ContentView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI
import SwiftData

struct MasterView: View {
    @StateObject var manager = LocationManager()
    @StateObject var observer = RestaurantObserver()
    @StateObject var tabManager = TabManager()
    @StateObject var prefManager = PreferenceManager()
    
    @State var show:Bool = false

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
            .sheet(isPresented: $show, content: {
                Text("what")
            })
        }
        .environmentObject(manager)
        .environmentObject(observer) 
        .environmentObject(tabManager)
        .environmentObject(prefManager)
        .modelContainer(for: Restaurant.self)
    }
}

#Preview {
    MasterView()
}
