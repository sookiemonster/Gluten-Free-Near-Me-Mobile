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
        switch status {
        case .notDetermined: print("undetermined auth"); break;
        default : print("some other auth"); break;
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func panTo(position:Binding<MapCameraPosition>) {
        print("wah")
        print(position.wrappedValue)
        position.wrappedValue = MapCameraPosition.region(.somewhere)
    }
}
