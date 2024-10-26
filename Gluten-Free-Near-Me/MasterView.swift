//
//  ContentView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct MasterView: View {
    var body: some View {
        TabView() {
            MapView()
        }
    }
}

#Preview {
    MasterView()
}
