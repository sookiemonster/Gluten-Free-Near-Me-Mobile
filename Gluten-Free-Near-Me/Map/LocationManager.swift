//
//  LocationHandler.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI
import Foundation
import CoreLocation
import MapKit

extension MKCoordinateRegion {
    static let somewhere = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: 40.7038, longitude: -73.877), latitudinalMeters: 500, longitudinalMeters: 500)
}

class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var hasLocationAuthorization:Bool = false;
    @Published var isAnimating:Bool = true;
    
    private var cameraPosition:Binding<MapCameraPosition>?
    private let manager = CLLocationManager();
    var location:CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        updateAuth()
        manager.startUpdatingLocation()
    }
    
    func updateAuth() {
        let status = manager.authorizationStatus
        hasLocationAuthorization = (status == .authorizedAlways || status == .authorizedWhenInUse)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        updateAuth()
        #if DEBUG
        switch status {
        case .notDetermined: print("undetermined auth"); break;
        default : print("some other auth"); break;
        }
        #endif
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func setCameraPosition(position:Binding<MapCameraPosition>) {
        self.cameraPosition = position
    }
    
    func panTo(center:CLLocationCoordinate2D) {
        guard cameraPosition != nil else { return ;}
        #if DEBUG
        print(center)
        print()
        #endif
        
        let newCamera = MKCoordinateRegion(
            center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.isAnimating = true;
        withAnimation() {
            cameraPosition!.wrappedValue = MapCameraPosition.region(newCamera)
        }
    }
    
    func completeAnimation() {
        print("completed anim")
        self.isAnimating = false;
    }
}
