//
//  DrillDownSelector.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/1/24.
//

import SwiftUI

enum DrillDownMode:String, CaseIterable {
    case compact = "Compact"
    case expanded = "Expanded"
}

struct DrillDownLabel : View {
    let content:String
    var body : some View {
        HStack(spacing: 0) {
            Text("View: ")
            Text(content)
                .bold()
                .tint(.accentColor)
        }
    }
}

struct DrillDownSelector: View {
    @Binding var selected:DrillDownMode;
    
    var body: some View {
        Menu {
            ForEach(DrillDownMode.allCases, id: \.self) { mode in
                Button {
                    withAnimation {
                        selected = mode
                    }
                } label: {
                    Text(mode.rawValue)
                }
            }
        } label: {
            DrillDownLabel(content: selected.rawValue)
        }
    }
}

#Preview {
    struct Dummy: View {
        @State var sel:DrillDownMode = .compact
        var body : some View {
            VStack {
                DrillDownSelector(selected: $sel)
                Spacer()
            }.fillWidth(alignment: .leading)
        }
    }
    
    return Dummy()
}
