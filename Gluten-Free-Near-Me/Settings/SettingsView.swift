//
//  SettingsView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            AccountViewer(username: "sampleUser", email: "email")
            ColorSetterView(name: "GF Reviews", modifying: .reviews)
            ColorSetterView(name: "GF Descriptions", modifying: .description)
        }
        .fillParent(alignment: .leading)
        .padding()
        .opaque()
    }
}

#Preview {
    SettingsView()
}
