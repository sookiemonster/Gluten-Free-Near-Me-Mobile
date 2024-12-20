//
//  RestaurantObserver.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/30/24.
//

import Foundation

class RestaurantObserver : ObservableObject {
    @Published var selected:Restaurant?
    
    init(selected:Restaurant? = nil) {
        self.selected = selected
    }
    
    func select(target:Restaurant) {
        self.selected = target
        print("select: " + target.name)
    }
    
    func deselect() {
        self.selected = nil
        print("deselecting...")
    }
    
    func isFocused() -> Bool {
        return selected != nil
    }
}
