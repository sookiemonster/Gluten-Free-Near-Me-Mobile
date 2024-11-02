//
//  ColorSetterView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/2/24.
//

import SwiftUI

struct ConfirmButton : View {
    let action:() -> Void
    var body : some View {
        Button("Save") {
            action()
        }
    }
}

struct ColorSetterView: View {
    @EnvironmentObject var prefManager:PreferenceManager
    @State private var picked:Color = .black
    @State private var showConfirmation = false
    let name:String
    let modifying:Mentioner
    
    init(name:String, modifying:Mentioner) {
        self.name = name
        self.modifying = modifying
    }
    
    func setInitialColor() -> Void {
        self.picked = self.prefManager.getStored(colorCategory: modifying)
    }
    
    func hasChanged() -> Bool {
        return prefManager.getStored(colorCategory: modifying) != picked
    }
    
    func differsFromDefault() -> Bool {
        return prefManager.getStored(colorCategory: modifying) != prefManager.getDefault(colorCategory: modifying)
    }
    
    @ViewBuilder
    func renderReset() -> some View {
        if (differsFromDefault()) {
            Button {
                showConfirmation = true;
            } label: {
                Image(systemName: "arrow.2.squarepath")
                    .foregroundColor(.white.opacity(0.7))
            }
            .filled(color: .opague.opacity(0.2), size: 40)
        }
    }
    
    @ViewBuilder
    func renderSave() -> some View {
        if (hasChanged()) {
            ConfirmButton {
                prefManager.set(colorCategory: modifying, color: picked)
            }
        }
    }
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            renderSave()
            ColorPicker("", selection: $picked, supportsOpacity: false)
                .frame(width: 40)
                .onAppear {
                    setInitialColor()
                }
            renderReset()
                .confirmationDialog("Reset to Default?", isPresented: $showConfirmation) {
                    Button("Yes") {
                        withAnimation {
                            prefManager.set(colorCategory: modifying, color: prefManager.getDefault(colorCategory: modifying))
                            picked = prefManager.getDefault(colorCategory: modifying)
                        }
                    }
                    Button("No") {}
                } message: {
                    Text("Reset color to default?")
                        .font(.subheadline)
                }
        }
        
    }
}

#Preview {
    ColorSetterView(name: "Review Color", modifying: .menu)
        .environmentObject(PreferenceManager())
}
