//
//  TabManager.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import Foundation

class TabManager : ObservableObject {
    @Published var selectedTab:Tab = .home
    
    func select(newTab:Tab) {
        selectedTab = newTab
    }
}
