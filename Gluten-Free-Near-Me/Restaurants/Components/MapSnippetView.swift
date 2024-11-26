//
//  MapSnippetView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/19/24.
//

import SwiftUI
import MapKit

struct MapSnippetView: View {
    @EnvironmentObject private var prefManager:PreferenceManager
    let height:CGFloat = 200
    let camera:MapCameraPosition
    let place:Restaurant
    
    init(place:Restaurant) {
        let center = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
        self.camera = .region(MKCoordinateRegion(center:center, latitudinalMeters: 1000, longitudinalMeters: 1000))
        self.place = place
    }

    
    var body: some View {
        Map(initialPosition: self.camera, interactionModes: []) {
            Annotation(LocalizedStringKey(stringLiteral: place.name), coordinate: place.loc()) {
                RestaurantMarker(restaurant: place, prefManager: prefManager)
            }
        }
        
        .fillWidth()
        .frame(height: height)
        .cornerRadius(15)
    }
}

//#Preview {
////    MapSnippetView(plae
//}
