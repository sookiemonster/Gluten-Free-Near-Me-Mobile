//
//  PositionalSheet.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/10/24.
//

import SwiftUI
import Foundation

struct PositionalSheet<Content: View>: View {
    var content: Content
    var positions:[CGFloat]
    let handle_collision_height:CGFloat = 40;
    let anim_config:Animation = .bouncy(duration: 0.3);
    @State private var animating:Bool = false
    @ObservedObject private var controller:SheetController
    
    init(positions: [CGFloat] = [1.0, 0.5, 0.3], controller:StateObject<SheetController>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.positions = positions
        
        if (positions.isEmpty) {
            self.positions = [1.0, 0.5, 0.3]
        }
        self.controller = controller.wrappedValue
    }
    
    func setPositions() {
        controller.positions = self.positions
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
            .frame(height: handle_collision_height)
            .onTapGesture {
                withAnimation(anim_config) { controller.cycle() }
            }
            .gesture(DragGesture()
                .onChanged({ action in
                    if (animating) { return; }
                    animating = true;
                    let dy = action.translation.height
                    withAnimation(anim_config) {
                        if (dy > 0) { controller.collapse() }
                        else { controller.grow() }
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
                if (positions[controller.rendered_position] != 1.0) {
                    ScrollView {
                        content
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .padding([.leading, .trailing], 10)
                    .frame(width: geometry.size.width, height: geometry.size.height * (1 - positions[controller.rendered_position]))
                }
            }
        .fillWidth()
        .background(.thinMaterial)
        .offset(y: -1 * handle_collision_height)
        .offset(y: geometry.size.height * positions[controller.rendered_position])
        }
        .onAppear { setPositions() }
    }
}


#Preview {
    struct Preview : View{
        
        @StateObject var controller = SheetController()
        var body : some View {
            PositionalSheet(controller: _controller) {
                Text("aaa")
            }
        }
    }
    
    return Preview()
}
