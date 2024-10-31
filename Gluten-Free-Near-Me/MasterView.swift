//
//  ContentView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct MasterView: View {
    @StateObject var manager = LocationManager()

    var body: some View {
        TabView() {
            HomeView()
        }.environmentObject(manager)
    }
}

#Preview {
    MasterView()
}
