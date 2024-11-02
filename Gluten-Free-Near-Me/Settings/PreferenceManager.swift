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
    
    @AppStorage("userReviewColor") var rawReviewColor:String = ""
    @AppStorage("userDescriptionColor") var rawDescriptionColor:String = ""
    @AppStorage("userMenuColor") var rawMenuColor:String = ""
    
    @Published var reviewColor:Color = Color(.defaultReview)
    @Published var descriptionColor:Color = Color(.defaultDescription)
    @Published var menuColor:Color = Color(.defaultMenu)
    
    func stringToColor(colorString:String) -> Color {
        if (colorString.isEmpty) { return .black }
        
        let r:CGFloat = CGFloat(Int(colorString.prefix(3)) ?? 0) / 255.0
        let g:CGFloat = CGFloat(Int(colorString.prefix(6).suffix(3)) ?? 0) / 255.0
        let b:CGFloat = CGFloat(Int(colorString.suffix(3)) ?? 0) / 255.0
        
        return Color(.sRGB, red:r, green: g, blue: b)
    }
    
    func padZeroes(val:Int, target_length:Int) -> String {
        var padded = String(val)
        while (padded.count < target_length) { padded = "0" + padded }
        return padded;
    }
    
    func colorToString(color:Color) -> String {
        let actual = color.resolve(in: env)
        
        let r = padZeroes(val: Int(actual.red * 255.0), target_length: 3)
        let g = padZeroes(val: Int(actual.green * 255.0), target_length: 3)
        let b = padZeroes(val: Int(actual.blue * 255.0), target_length: 3)
        
        return r + g + b
    }
    
    init() {
        if (!rawReviewColor.isEmpty) { reviewColor = stringToColor(colorString: rawReviewColor) }
        if (!rawDescriptionColor.isEmpty) { descriptionColor = stringToColor(colorString: rawDescriptionColor) }
        if (!rawMenuColor.isEmpty) { menuColor = stringToColor(colorString: rawMenuColor) }
    }
    
    func set(colorCategory:Mentioner, color:Color? = nil) -> Void {
        var stringified:String = "";
        var newColor:Color = getDefault(colorCategory: colorCategory)
        if let received = color {
            stringified = colorToString(color: received)
            newColor = received
        }
    
        switch colorCategory {
        case .reviews: 
            rawReviewColor = stringified;
            reviewColor = newColor;
            return;
        case .description:
            rawDescriptionColor = stringified;
            descriptionColor = newColor;
            return;
        case .menu:
            rawMenuColor = stringified;
            menuColor = newColor;
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
    
    func reset(colorCategory:Mentioner) -> Void {
        set(colorCategory: colorCategory, color: nil)
    }
}
