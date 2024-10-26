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
    @StateObject private var controller = MapController()
    
    var body: some View {
        if let loc = controller.location {
            Map {
                
            }
            Text("\(loc)")
        } else {
        }
    }
}

#Preview {
    MapView()
}
