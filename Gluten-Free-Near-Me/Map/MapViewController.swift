//
//  SwiftUIView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import UIKit
import MapKit

class MapViewController : UIViewController {
    var mapView : MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//#Preview {
//    MapView()
//}
