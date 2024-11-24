//
//  ViewButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/30/24.
//

import SwiftUI
import MapKit

struct ViewButton: View {
    let restaurant:Restaurant
    @EnvironmentObject var manager:LocationManager
    @EnvironmentObject var observer:RestaurantObserver
    @EnvironmentObject var tabManager:TabManager
    
    var body: some View {
        Button {
            manager.panTo(center: restaurant.loc())
            observer.select(target: restaurant)
            tabManager.select(newTab: .home)
        } label: {
            Image(systemName: "map")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.text)
        }.filled(color: .transparent, size: 50)
    }
}

#Preview {
    Text("")
//    ViewButton()
}
