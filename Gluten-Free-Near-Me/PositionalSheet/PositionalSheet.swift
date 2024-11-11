//
//  PositionalSheet.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/10/24.
//

import SwiftUI

struct PositionalSheet<Content: View>: View {
    var content: Content
    var positions:[CGFloat]
    let handle_collision_height:CGFloat = 50;
    @State private var rendered_position:Int = 0
    
    init(@ViewBuilder content: () -> Content, positions: [CGFloat] = [1.0, 0.3]) {
        self.content = content()
        self.positions = positions
        
        if (positions.isEmpty) {
            self.positions = [1.0, 0.3]
        }
    }
    
    func cycle() -> Void {
        rendered_position = (rendered_position + 1) % positions.count
    }
    
    func Handle() -> some View {
        return ZStack {
            Capsule()
                .frame(width: 100, height: 4)
                .opacity(0.5)
                .padding()
        }
        .fillWidth()
        .contentShape(Rectangle())
            .onTapGesture {
                print("w")
                withAnimation(.bouncy) {
                    cycle()
                }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Handle()
                ScrollView {
                    content
                }
            }
        .fillWidth()
        .opaque()
        .offset(y: (-1 * handle_collision_height) + geometry.size.height * positions[rendered_position])
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PositionalSheet {
        Text("aaa")
    }
}
