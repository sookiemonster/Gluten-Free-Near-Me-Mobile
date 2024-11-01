//
//  ContentView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct NavButton : View {
    let name:String
    let iconString:String
    
    var body : some View {
        Button {
            print("a")
        } label: {
            Label(name, systemImage: iconString)
                .font(.title2)
        }.fillWidth()
    }
}
enum Tab:UInt8 {
    case home
    case saved
    case profile
}

struct MasterView: View {
    @StateObject var manager = LocationManager()
    @StateObject var observer = RestaurantObserver()
    @State var tab:Tab = .home

    var body: some View {
        NavigationStack {
            ZStack {
                HomeView()
                
                switch tab {
                case .home: EmptyView()
                case .saved: SavedView().opaque()
                case .profile:
                    Text("Settings")
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        NavButton(name: "Home", iconString: "house.fill")
                        NavButton(name: "Saved", iconString: "heart")
                        NavButton(name: "Profile", iconString: "person.fill")
                    }
                }
            }.toolbarBackground(.visible, for: .bottomBar)
        }
        .environmentObject(manager)
        .environmentObject(observer) 
    }
}

#Preview {
    MasterView()
}
