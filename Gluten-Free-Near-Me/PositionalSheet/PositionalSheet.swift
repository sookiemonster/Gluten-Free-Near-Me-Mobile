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
    let offset:CGFloat
    let handle_collision_height:CGFloat = 50;
    let anim_config:Animation = .bouncy(duration: 0.3);
    @State private var rendered_position:Int = 0
    @State private var animating:Bool = true
    
    init(offset: CGFloat, positions: [CGFloat] = [1.0, 0.5, 0.3], @ViewBuilder content: () -> Content) {
        self.content = content()
        self.offset = offset
        self.positions = positions
        
        if (positions.isEmpty) {
            self.positions = [1.0, 0.5, 0.3]
        }
    }
    
    func cycle() -> Void {
        rendered_position = (rendered_position + 1) % positions.count
    }
    
    func grow() -> Void {
        if (rendered_position == positions.count - 1) { return ;}
        rendered_position += 1
    }
    
    func collapse() -> Void {
        if (rendered_position == 0) { return; }
        
        rendered_position = 0
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
                withAnimation(anim_config) { cycle() }
            }
            .gesture(DragGesture()
                .onChanged({ action in
                    if (animating) { return; }
                    animating = true;
                    let dy = action.translation.height
                    withAnimation(anim_config) {
                        
                        if (dy > 0) { collapse() }
                        else { grow() }
                    }
                })
                .onEnded({action in
                    animating = false;
                })
            )
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
        .offset(y: -20)
    }
}

#Preview {
    PositionalSheet(offset: -20) {
        Text("aaa")
    }
}
