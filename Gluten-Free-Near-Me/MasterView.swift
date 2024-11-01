//
//  ContentView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

extension View {
    func navOption(name:String, iconString:String) -> some View {
        self
            .tabItem {
                Label(name, systemImage: iconString)
            }
    }
}

struct MasterView: View {
    @StateObject var manager = LocationManager()
    @StateObject var observer = RestaurantObserver()

    var body: some View {
        TabView() {
            HomeView()
                .navOption(name: "Home", iconString: "house.fill")
            Text("Saved")
                .navOption(name: "Saved", iconString: "heart")
            Text("Settings")
                .navOption(name: "Profile", iconString: "person.fill")
        }
        .environmentObject(manager)
        .environmentObject(observer)
        
    }
}

#Preview {
    MasterView()
}
