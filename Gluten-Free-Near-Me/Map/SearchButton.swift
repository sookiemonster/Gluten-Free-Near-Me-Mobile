//
//  SearchButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct SearchButton: View {
    @Binding var restaurants:[Place];
    func requestNearby() { return; }
    
    var body: some View {
        Button {
            requestNearby()
        } label: {
            Text("Search Here")
                .fontWeight(.bold)
                .tint(.white)
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 30)
        .background(.opague)
        .cornerRadius(50.0)
    }
}

#Preview {
    VStack { 
        SearchButton(restaurants: .constant([]))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray)
    
    
}
