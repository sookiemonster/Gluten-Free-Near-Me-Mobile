//
//  SheetController.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/18/24.
//

import Foundation
import SwiftUI

class SheetController : ObservableObject {
    @Published var rendered_position:Int = 0
    @Published var positions:[CGFloat] = []
    @Published private var isPresented = true
    
    let anim_config:Animation = .bouncy(duration: 0.3);
    
    func cycle() -> Void {
        rendered_position = (rendered_position + 1) % positions.count
    }
    
    func grow() -> Void {
        if (rendered_position == positions.count - 1) { return ;}
        withAnimation(anim_config) {
            rendered_position += 1
        }
    }
    
    func collapse() -> Void {
        if (rendered_position == 0) { return; }
        rendered_position = 0
    }
    
    func isVisible() -> Bool {
        return self.isPresented
    }
    
    func show() -> Void {
        if isPresented { return ;}
        self.isPresented = true
    }
    
    func hide() -> Void {
        if !isPresented { return; }
        self.isPresented = false
    }
}
