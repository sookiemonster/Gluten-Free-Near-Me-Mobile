//
//  Styling.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/1/24.
//

import SwiftUI

extension View {
    func opague() -> some View{
        self
            .background(.ultraThinMaterial)
    }
}

#Preview {
    Circle()
        .opague()
}
