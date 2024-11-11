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
        maximumDistance: 10000
    )
}

struct MapView: View {
    @State private var position:MapCameraPosition = MapCameraPosition.userLocation(fallback: .automatic)
    
    @EnvironmentObject var manager:LocationManager;
    @EnvironmentObject var observer:RestaurantObserver;
//    @EnvironmentObject var store:RestaurantStore;
    
    func isCloseBy(p1:CLLocationCoordinate2D, p2:CLLocationCoordinate2D) -> Bool {
        let TOLERANCE = 0.0005
        return abs(p1.latitude - p2.latitude) < TOLERANCE 
            && abs(p1.longitude - p2.longitude) < TOLERANCE
    }
    
    @MapContentBuilder
    func RestaurantAnnotations(toMap:[Restaurant]) -> some MapContent {
        ForEach (toMap) { place in
            Annotation(LocalizedStringKey(stringLiteral: place.name), coordinate: place.loc()) {
                RestaurantMarker(restaurant: place)
                    .onTapGesture {
                        manager.panTo(center: place.loc())
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
        .onMapCameraChange(frequency: .continuous) { context in
            manager.viewportRegion = context.region
            guard let target = observer.selected else { return; }
            
            let newCenter = context.region.center
            let mapCenteredAtRestaurant = isCloseBy(p1: target.loc(), p2: newCenter)
            
            #if DEBUG
            print("Centered?: ", mapCenteredAtRestaurant)
            print("MapCenter: ", newCenter)
            print("TargetCenter: ", target.loc)
            #endif
            
            if (manager.isAnimating && mapCenteredAtRestaurant) {
                manager.completeAnimation();
            } else if (!manager.isAnimating && !mapCenteredAtRestaurant) {
                observer.deselect()
            }
            
        }
    }
}
