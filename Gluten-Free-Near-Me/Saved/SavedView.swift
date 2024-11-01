//
//  SavedView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/1/24.
//

import SwiftUI

struct SavedHeader: View {
    @Binding var detailMode:DrillDownMode;
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Saved Restaurants")
                .font(.largeTitle)
                .bold()
            DrillDownSelector(selected: $detailMode)
        }.fillWidth(alignment: .leading)
            .padding(30)
    }
}

struct SavedView: View {
    @State private var detailMode:DrillDownMode = .compact;
    
    var body: some View {
        VStack {
            SavedHeader(detailMode: $detailMode)
            Spacer()
        }.fillParent()
    }
}

#Preview {
    SavedView()
}
