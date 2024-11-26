//
//  Navigation.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import SwiftUI

struct NavButton : View {
    @EnvironmentObject var tabManager:TabManager;
    let name:String
    let iconString:String
    let targetTab:Tab
    
    var body : some View {
        Button {
            withAnimation(.linear(duration: 0.13)) {
                tabManager.select(newTab: targetTab)
            }
        } label: {
            if (tabManager.selectedTab == targetTab) {
                Label(name, systemImage: iconString + ".fill")
                    .font(.title2)
                    .foregroundColor(.accentColor)
            } else {
                Label(name, systemImage: iconString)
                    .font(.title2)
                    .foregroundColor(.text)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
        }.fillWidth()
    }
}

// Ref: https://www.avanderlee.com/swiftui/disable-animations-transactions/
extension View {
    func navigationToolbar() -> some View {
        self
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    NavButton(name: "Home", iconString: "house", targetTab: .home)
                    NavButton(name: "Saved", iconString: "heart", targetTab: .saved)
                    NavButton(name: "Profile", iconString: "person", targetTab: .profile)
                }.transaction { transaction in
                    // Bug Fix: Prevent navigation bar from sliding in
                    transaction.animation = nil
                    
                }
            }
        }
        .toolbarBackground(.visible, for: .bottomBar)
    }
}

enum Tab:UInt8 {
    case home
    case saved
    case profile
}
