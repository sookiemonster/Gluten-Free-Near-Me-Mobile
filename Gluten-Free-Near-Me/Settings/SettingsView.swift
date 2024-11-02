//
//  SettingsView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import SwiftUI

struct SettingsView: View {
    let showAccount:Bool = false;
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            if (showAccount) {
                AccountViewer(username: "sampleUser", email: "email")
                    .padding(.bottom, 20)
            }
            VStack {
                
                ColorSetterView(name: "GF Reviews", modifying: .reviews)
                Divider()
                ColorSetterView(name: "GF Descriptions", modifying: .description)
            }
            Spacer()
        }
        .fillParent(alignment: .leading)
        .responsiveSquarePadding(scale: 0.1)
        .opaque()
    }
}

#Preview {
    SettingsView()
}
