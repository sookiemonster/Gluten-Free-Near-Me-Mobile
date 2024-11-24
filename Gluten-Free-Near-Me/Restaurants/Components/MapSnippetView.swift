//
//  MapSnippetView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/19/24.
//

import SwiftUI
import MapKit

struct MapSnippetView: View {
    let height:CGFloat = 200
    var body: some View {
        Map()
            .fillWidth()
            .frame(height: height)
            .cornerRadius(15)
    }
}

#Preview {
    MapSnippetView()
}
