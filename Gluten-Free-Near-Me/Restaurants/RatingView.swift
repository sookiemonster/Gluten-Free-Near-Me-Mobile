//
//  RatingView.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 10/30/24.
//

import SwiftUI

struct RatingView: View {
    private let size:CGFloat
    private let color:Color
    private let rating:Double
    
    private var fractional:Double
    private var whole:UInt8
    
    init(rating:Double, size:CGFloat=30, color:Color = Color(.white)) {
        let clamped = min(max(rating, 0.0), 5.0)
        self.rating = rating
        self.whole = UInt8(floor(clamped))
        self.fractional = 1 - (clamped - Double(whole))
        self.color = color
        self.size = size
    }
    
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                if (i < whole) {
                    Circle()
                        .foregroundColor(color)
                        .frame(width: size)
                } else if (i == whole) {
                    ZStack {
                        Circle()
                            .stroke(color)
                            .foregroundColor(color)
                            .frame(width: size)
                        Rectangle()
//                            .trim(from: 0, to: 0.5)
                            .offset(CGSize(width: fractional * size, height: 0.0))
                            .rotationEffect(.degrees(180))
                            .frame(width: size, height: size)
                            .clipShape(Circle())
                            .foregroundColor(color)
                    }
                } else {
                    Circle()
                        .stroke(color)
                        .foregroundColor(color)
                        .frame(width: size)
                }
            }
            Text("\(rating, specifier: "%.1f")")
                .foregroundColor(color)
                .bold()
                .font(.system(size: size))
                .padding([.leading], size / 5)
        }.frame(height: size)
    }
}

#Preview {
    RatingView(rating: 0.4)
}
