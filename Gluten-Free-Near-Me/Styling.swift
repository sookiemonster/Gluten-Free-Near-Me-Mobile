//
//  Styling.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/1/24.
//

import SwiftUI

extension View {
    func opaque() -> some View{
        self
            .background(.ultraThinMaterial)
            
    }
}

extension View {
    func fillParent(alignment:Alignment = .center) -> some View {
        self
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .leading)
    }
    
    func fillWidth(alignment:Alignment = .center) -> some View {
        self
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
}

#Preview {
    Circle()
        .opaque()
}
