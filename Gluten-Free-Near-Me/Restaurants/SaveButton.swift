//
//  SaveButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/27/24.
//

import SwiftUI

struct SaveButton: View {
    @State private var saved:Bool;
    
    init(saved:Bool) {
        self._saved = State(initialValue: saved)
    }
    
    func toggle() { saved = !saved }
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
        
        
    }
}

#Preview {
    SaveButton(saved: false)
}
