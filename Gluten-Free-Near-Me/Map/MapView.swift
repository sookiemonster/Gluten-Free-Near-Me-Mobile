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
    @EnvironmentObject var observer:RestaurantObserver;
//    @EnvironmentObject var store:RestaurantStore;
    
    func isCloseBy(p1:CLLocationCoordinate2D, p2:CLLocationCoordinate2D) -> Bool {
        let TOLERANCE = 0.00005
        return (p1.latitude - p2.latitude) < TOLERANCE && (p1.longitude - p2.longitude) < TOLERANCE
    }
    
    @MapContentBuilder
    func RestaurantAnnotations(toMap:[Restaurant]) -> some MapContent {
        ForEach (toMap) { place in
            Annotation(LocalizedStringKey(stringLiteral: place.name), coordinate: place.loc) {
                Image(systemName: "fork.knife.circle.fill")
                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                    .font(.largeTitle)
                    .onTapGesture {
                        manager.panTo(center: place.loc)
                        observer.select(target: place)
                    }
            }
        }
    }

    var body: some View {
        Map(position: $position, bounds: .config, interactionModes: .all) {
            UserAnnotation()
            RestaurantAnnotations(toMap: RestaurantStore.sample_places)
            
        }.mapControls {
            MapUserLocationButton()
        }.onAppear {
            manager.setCameraPosition(position: $position)
        }
        .onMapCameraChange(frequency: .onEnd) { context in
            guard let target = observer.selected else { return; }
            
            let newCenter = context.region.center
            if (!isCloseBy(p1: target.loc, p2: newCenter)) {
                observer.deselect()
            }
        }
    }
}
