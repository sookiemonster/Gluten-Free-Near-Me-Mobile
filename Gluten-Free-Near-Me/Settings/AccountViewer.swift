//
//  AccountViewer.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import SwiftUI

struct AccountViewer: View {
    let username:String
    let email:String
    var icon:String?
    
    var body: some View {
        VStack {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(username).bold()
                    Text(email).font(.subheadline).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                
                if (icon == nil) {
                    Image(systemName: "person")
                        .padding()
                        .background(.white.opacity(0.2))
                        .clipShape(Circle())
                } else {
//                    Image()
                }
            }
            .fillWidth(alignment: .leading)
            .padding()
            .border(.text.opacity(0.2))
            if (icon != nil) {
                HStack(spacing: 4) {
                    Spacer()
                    Text("Not You?")
                    Text("Switch Accounts").bold()
                }.font(.subheadline)
            }
        }
    }
}

#Preview {
//    AccountViewer(username: "Daniel Sooknanan", email: "daniel.sooknanan16@myhunter.cuny.edu")
    AccountViewer(username: "Daniel Sooknanan", email: "daniel.sooknanan16@myhunter.cuny.edu", icon: "something")
}
