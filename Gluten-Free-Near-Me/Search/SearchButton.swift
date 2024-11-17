//
//  SearchButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct SearchButton: View {
//    @Binding var restaurants:[Place];
    @EnvironmentObject var manager:LocationManager;
    
    var body: some View {
        Button {
            DispatchQueue(label: "search").async {
                Task {
                    await manager.searchViewport()
                }
            }
        } label: {
            Text("Search Here")
                .fontWeight(.bold)
                .tint(.text)
        }
        .padding([.top, .bottom], 12)
        .padding([.leading, .trailing], 30)
        .opaque()
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.text).opacity(0.2))
    }
}

#Preview {
    VStack { 
//        SearchButton(restaurants: .constant([]))
        SearchButton()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray)
    
    
}