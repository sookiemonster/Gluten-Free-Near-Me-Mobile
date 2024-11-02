//
//  PreferenceManager.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import Foundation
import SwiftUI

class PreferenceManager : ObservableObject {
    @Published var reviewColor:Color
    @Published var descriptionColor:Color
    @Published var menuColor:Color
    
    init() {
        reviewColor = .white
        descriptionColor = .white
        menuColor = .white
    }
}
