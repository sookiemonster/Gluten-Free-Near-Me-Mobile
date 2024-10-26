//
//  LocationHandler.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var hasLocationAuthorization:Bool = false;
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.93, longitude: -79.3),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    private let manager = CLLocationManager();
    
    override init() {
        super.init()
        manager.delegate = self
        updateAuth()
        centerOnUser()
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
    
    func centerOnUser(){
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        manager.stopUpdatingLocation()
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
}
