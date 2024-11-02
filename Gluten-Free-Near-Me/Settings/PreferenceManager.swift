//
//  PreferenceManager.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import Foundation
import SwiftUI
import Combine

class PreferenceManager : ObservableObject {
    @Environment(\.self) var env
    
    @AppStorage("userReviewColor") var rawReviewColor:Int = -1
    @AppStorage("userDescriptionColor") var rawDescriptionColor:Int = -1
    @AppStorage("userMenuColor") var rawMenuColor:Int = -1
    
    @Published var reviewColor:Color = Color(.defaultReview)
    @Published var descriptionColor:Color = Color(.defaultDescription)
    @Published var menuColor:Color = Color(.defaultMenu)
    
    func parseColorInt(colorInt:Int) -> Color {
        if (colorInt < 0x000000 || colorInt > 0xFFFFFF) { return .black }
        
        // Mask the components of the stored raw value & normalize to [0.0, 1.0]
        let r_comp:CGFloat = CGFloat(colorInt & 0xFF0000) / 0xFF0000;
        let g_comp:CGFloat = CGFloat(colorInt & 0x00FF00) / 0x00FF00;
        let b_comp:CGFloat = CGFloat(colorInt & 0x0000FF) / 0x0000FF;
        
        return Color(red:r_comp, green: g_comp, blue: b_comp)
    }
    
    func parseColor(color:Color) -> Int {
        let actual = color.resolve(in: env)
        
        return Int(actual.red * 0xFF0000) + Int(actual.green * 0x00FF00) + Int(actual.blue * 0x0000FF)
    }
    
    init() {
        if (rawReviewColor > 0) { reviewColor = parseColorInt(colorInt: rawReviewColor) }
        if (rawDescriptionColor > 0) { descriptionColor = parseColorInt(colorInt: rawDescriptionColor) }
        if (rawMenuColor > 0) { menuColor = parseColorInt(colorInt: rawMenuColor) }
    }
    
    func set(colorCategory:Mentioner, color:Color) -> Void {
        let colorInt:Int = parseColor(color: color)
        
        if (colorInt < 0x000000 || colorInt > 0xFFFFFF) { return }
        
        switch colorCategory {
        case .reviews: 
            rawReviewColor = colorInt;
            reviewColor = color;
            return;
        case .description:
            rawDescriptionColor = colorInt;
            descriptionColor = color;
            return;
        case .menu:
            rawMenuColor = colorInt;
            menuColor = color;
            return;
        default: return;
        }
    }
    
    func getStored(colorCategory:Mentioner) -> Color {
        switch colorCategory {
        case .reviews: return reviewColor
        case .description: return descriptionColor
        case .menu: return menuColor
        default: return .black;
        }
    }
    
    func getDefault(colorCategory:Mentioner) -> Color {
        switch colorCategory {
        case .reviews: return Color(.defaultReview)
        case .description: return Color(.defaultDescription)
        case .menu: return Color(.defaultMenu)
        default: return .black;
        }
    }
}
