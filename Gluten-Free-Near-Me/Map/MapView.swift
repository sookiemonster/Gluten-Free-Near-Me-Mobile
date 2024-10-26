//
//  SwiftUIView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI
import UIKit
import MapKit

struct MapView: View {
    @StateObject private var controller = LocationManager()
    let cameraBounds = MapCameraBounds(
        minimumDistance: 1,
        maximumDistance: 100000
    )
    let userPosition = MapCameraPosition.userLocation(fallback: .automatic)

    
    var body: some View {
        Map(initialPosition: userPosition, bounds: cameraBounds, interactionModes: .all) {
            UserAnnotation()
        }.mapControls {
            MapUserLocationButton()
        }
    }
}

#Preview {
    MapView()
}
