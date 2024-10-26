//
//  MapView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/26/24.
//

import SwiftUI

struct MapView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // stub
    }
}

#Preview {
    MapView()
}
