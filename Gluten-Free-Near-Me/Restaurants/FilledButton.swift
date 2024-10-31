//
//  FilledButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/30/24.
//

import SwiftUI

extension Button {
    func filled(color:Color, size:CGFloat) -> some View {
        self
            .frame(width: size, height: size)
            .background(color)
            .cornerRadius(15)
    }
}

#Preview {
    Button {
        
    } label: {
        Image(systemName: "eye")
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }.filled(color: .red, size: 40)
    
}
