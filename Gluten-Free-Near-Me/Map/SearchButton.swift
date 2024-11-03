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
            manager.searchViewport()
        } label: {
            Text("Search Here")
                .fontWeight(.bold)
                .tint(.text)
        }
        .padding([.top, .bottom], 12)
        .padding([.leading, .trailing], 30)
        .background(.opague)
        .cornerRadius(50.0)
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
