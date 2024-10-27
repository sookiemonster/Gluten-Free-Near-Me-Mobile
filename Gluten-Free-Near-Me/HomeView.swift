//
//  HomeView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            MapView()
            VStack {
                Spacer()
                SearchButton()
                    .padding()
//                Restaurants()
            }
        }
    }
}

#Preview {
    HomeView()
}
