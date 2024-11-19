//
//  NotFoundView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/18/24.
//

import SwiftUI

struct NotFoundView: View {
    var body: some View {
        VStack(spacing: 2) {
            Spacer()
            Image(systemName: "xmark.circle")
                .font(.title)
                .padding(.bottom, 20)
            Text("No Restaurants Found")
                .font(.title2)
            Text("We couldn't find anything.")
                .padding(.bottom, 20)
            Text("Maybe try somewhere else?")
            Spacer()
        }
        .padding([.leading, .trailing], 30)
    }
}

#Preview {
    NotFoundView()
}
