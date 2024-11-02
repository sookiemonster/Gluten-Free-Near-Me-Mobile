//
//  SaveButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/27/24.
//

import SwiftUI

struct SaveButton: View {
    @State private var saved:Bool;
    @State private var showingConfirm:Bool = false
    let placeName:String
    
    init(name:String, saved:Bool) {
        self.placeName = name
        self._saved = State(initialValue: saved)
    }
    
    func toggle() {
        if (saved) { showingConfirm = true }
        else { saved = !saved }
    }
    func renderedSymbol() -> String {
        return "heart" + ((saved) ? ".fill" : "")
    }
    
    var body: some View {
        Button {
            toggle()
        } label: {
            Image(systemName: renderedSymbol() ).font(.title)
                .foregroundColor(.text)
        }.filled(color: .transparent, size: 50)
        .symbolEffect(.bounce, value: saved)
        .confirmationDialog("Remove Saved", isPresented: $showingConfirm) {
            Button("Yes") { saved = false }
            Button("No") {}
        } message: {
            Text("\(placeName) will be removed from your saved restaurants.")
                .font(.subheadline)
        }
    }
}

#Preview {
    SaveButton(name: "Wendys", saved: false)
}
