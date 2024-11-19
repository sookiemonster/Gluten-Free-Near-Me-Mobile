//
//  SearchButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/25/24.
//

import SwiftUI

struct SearchButton: View {
//    @Binding var restaurants:[Place];
    @EnvironmentObject var manager:LocationManager;
    @EnvironmentObject var resManager:RestaurantManager;
    @EnvironmentObject var sheetController:SheetController
    @State private var isLoading = false;
    
    let anim_config:Animation = .linear(duration: 0.3);

    var body: some View {
        Button {
            withAnimation(anim_config) {
                isLoading = true;
            }
            DispatchQueue(label: "search").async {
                resManager.clear_unsaved()
                Task {
                    await manager.searchViewport(resManager: resManager, callback: {
                        print("finished")
                        sheetController.grow()
                        withAnimation(anim_config) {
                            isLoading = false
//                            sheetController.show()
                        }
                    })
                }
            }
        } label: {
            if (isLoading) {
                Text("LOADING")
            } else {
                Text("Search Here")
                    .fontWeight(.bold)
                    .tint(.text)
            }
        }
        .padding([.top, .bottom], 12)
        .padding([.leading, .trailing], 30)
        .opaque()
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.text).opacity(0.2))
    }
}

#Preview {
    VStack { 
//        SearchButton(restaurants: .constant([]))
        SearchButton()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray)
    
    
}
