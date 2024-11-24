//
//  FullRestaurantPage.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/19/24.
//

import SwiftUI

extension View {
    func center() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}

struct PageBackground<Content: View> : View {
    var content:Content
    var color:Color
    
    init(color: Color, @ViewBuilder content: () -> Content) {
        self.color = color
        self.content = content()
    }
    
    var body : some View {
        ZStack {
            Rectangle()
            .foregroundStyle(
                LinearGradient(stops: [
                    .init(color: color, location: 0.2),
                    .init(color: color.opacity(0), location: 1),
                ], startPoint: .top, endPoint: .bottom)
            )
            .ignoresSafeArea()
            content
        }
    }
}

struct PageLabel : View {
    let text:String
    var body: some View {
        Text(text)
            .bold()
            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            .center()
    }
}


struct PageHeader: View {
    let place:Restaurant
    var body: some View {
        VStack(alignment: .leading) {
            Text(place.name)
                .font(.title)
                .bold()
//            Text("Address")
//                .font(.subheadline)
//                .foregroundColor(.text.opacity(0.6))
            RatingView(rating: place.rating, size: 15)
        }
    }
}

struct PageBody : View {
    let showReviews:Bool
    let place:Restaurant
    
    init(place: Restaurant) {
        self.place = place
        guard let reviews = place.reviews else {
            self.showReviews = false;
            return;
        }
        self.showReviews = !reviews.isEmpty
    }
    
    var body : some View {
        Text("Description")
            .font(.headline)
        Text(place.googDescription)
            .font(.body)
            .foregroundColor(.text.opacity(0.7))
        if showReviews {
            Spacer().frame(height:20)
            Text("Reviews")
                .font(.headline)
            ReviewsView(place: place, condensed: false)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }
    }
}


struct FullRestaurantPage: View {
//    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var prefManager:PreferenceManager
    @State var color:Color = .black
    
    let place:Restaurant
    
    func init_color() {
        color = place.getColor(prefManager: prefManager)
    }
    
    var body: some View {
        PageBackground(color: color) {
            VStack(alignment: .leading) {
                PageLabel(text: place.getHeader())
                Divider().opacity(0)
                PageHeader(place: place)
                Divider().opacity(0).padding(5)
                HStack {
                    MapSnippetView(place: place)
                        .padding(.bottom, 20)
                }.fillWidth()
                PageBody(place: place)
                Spacer()
                HStack {
                    Spacer()
                    SaveButton(restaurant: place)
                        .background(color)
                        .cornerRadius(15)
                    ShareButton(linkString: place.googURI)
                        .background(color)
                        .cornerRadius(15)
                    Spacer()
                }
                Spacer()
            }.fillParent()
                .responsiveSquarePadding(scale: 0.1)
                .onAppear {
                    init_color()
                }
            }
        }
}

struct PreviewFull :  View {
    @StateObject var prefManager = PreferenceManager()
    @StateObject var resManager = RestaurantManager()
    
    var body : some View {
        FullRestaurantPage(place: Restaurant.sample_place_1())
            .environmentObject(prefManager)
            .environmentObject(resManager)
            .modelContainer(resManager.container)
    }
}

#Preview {
    PreviewFull()
}
