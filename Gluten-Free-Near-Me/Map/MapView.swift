//
//  MapView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/26/24.
//

import SwiftUI
import UIKit
import MapKit

extension MapCameraBounds {
    static let config = MapCameraBounds(
        minimumDistance: 1,
        maximumDistance: 100000
    )
}

struct MapView: View {
    @State private var position:MapCameraPosition = MapCameraPosition.userLocation(fallback: .automatic)
    
    @EnvironmentObject var manager:LocationManager;

    var body: some View {
        Map(position: $position, bounds: .config, interactionModes: .all) {
            UserAnnotation()
        }.mapControls {
            MapUserLocationButton()
        }.onAppear {
            manager.setCameraPosition(position: $position)
        }
    }
}

#Preview {
//    MapView()
    Text("a")
}
