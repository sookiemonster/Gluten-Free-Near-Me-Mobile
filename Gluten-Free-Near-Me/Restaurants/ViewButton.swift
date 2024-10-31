//
//  ViewButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/30/24.
//

import SwiftUI
import MapKit

struct ViewButton: View {
    let navToLoc:CLLocationCoordinate2D
    @EnvironmentObject var manager:LocationManager
    
    var body: some View {
        Button {
            manager.panTo(center: navToLoc)
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
