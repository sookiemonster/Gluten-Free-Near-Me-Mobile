//
//  ShareButton.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/11/24.
//

import SwiftUI
import UIKit
import SafariServices

// Ref: https://www.hackingwithswift.com/read/32/3/how-to-use-sfsafariviewcontroller-to-browse-a-web-page

// Ref 2: https://stackoverflow.com/questions/56518029/how-do-i-use-sfsafariviewcontroller-with-swiftui

// Ref 3: https://www.hackingwithswift.com/example-code/strings/how-to-load-a-string-from-a-website-url

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
}

struct ShareButton: View {
    var url:URL?
    @State private var showSafari = false;
    @State private var showAlert = false;
    
    init(linkString: String) {
        self.url = nil
        initLink(linkString: linkString)
    }
    
    mutating func initLink(linkString:String)  {
        if let url = URL(string: linkString) {
            Task {
                let (_, _) = try await URLSession.shared.data(from: url)
            }
    //                _ = try String(contentsOf: url)
            self.url = url
        } else {
            self.url = nil
        }
    }
    
    func open() -> Void {
        if url != nil {
            showSafari.toggle()
        } else {
            showAlert.toggle()
        }
    }
    
    var body : some View {
        Button {
            print(url)
            open()
        } label: {
            Image(systemName: "globe").font(.title)
                .foregroundColor(.white)
        }.filled(color: .transparent, size: 50)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Could not access Google Maps page"),
                message: Text("An error occurred accessing the restaurant's Google Maps Page."))
        }
        .fullScreenCover(isPresented: $showSafari) {
            SafariView(url: url!)
                .ignoresSafeArea()
        }
    }
}


#Preview {
    ShareButton(linkString: "httpawdscom")
}
