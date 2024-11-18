//
//  SheetController.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/18/24.
//

import Foundation

class SheetController : ObservableObject {
    @Published var shouldExpand:Bool = false
    @Published var rendered_position:Int = 0
    @Published var positions:[CGFloat] = []
    
    func cycle() -> Void {
        rendered_position = (rendered_position + 1) % positions.count
    }
    
    func grow() -> Void {
        print("trying to open")
        print(positions)
        print(rendered_position)
        if (rendered_position == positions.count - 1) { return ;}
        rendered_position += 1
    }
    
    func collapse() -> Void {
        if (rendered_position == 0) { return; }
        rendered_position = 0
    }
}
