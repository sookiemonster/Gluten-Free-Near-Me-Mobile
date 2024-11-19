//
//  SaveButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/27/24.
//

import SwiftUI

struct SaveButton: View {
    @State private var showingConfirm:Bool = false
    let restaurant:Restaurant
    let anim_config:Animation = .easeOut(duration: 0.2)
    
    init(restaurant:Restaurant) {
        self.restaurant = restaurant
    }
    
    func toggle() {
        if (restaurant.isSaved) { showingConfirm = true; return; }
        withAnimation(anim_config) { restaurant.isSaved = true }
    }
    func renderedSymbol() -> String {
        return "heart" + ((restaurant.isSaved) ? ".fill" : "")
    }
    
    var body: some View {
        Button {
            toggle()
        } label: {
            Image(systemName: renderedSymbol() ).font(.title)
                .foregroundColor(.text)
        }.filled(color: .transparent, size: 50)
            .symbolEffect(.bounce, value: restaurant.isSaved)
        .confirmationDialog("Remove Saved", isPresented: $showingConfirm) {
            Button("Yes") { 
                withAnimation(anim_config) { restaurant.isSaved = false }
            }
            Button("No") {}
        } message: {
            Text("\(restaurant.name) will be removed from your saved restaurants.")
                .font(.subheadline)
        }
    }
}

#Preview {
    SaveButton(restaurant: .sample_place_1())
}
