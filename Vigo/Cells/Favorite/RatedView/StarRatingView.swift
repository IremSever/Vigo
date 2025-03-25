//
//  StarRatingView.swift
//  Vigo
//
//  Created by İrem Sever on 20.03.2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct StarRatingView: View {
    var rating: Int
    var maxRating: Int = 5

    @State private var animatedRating: Int = 0

    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<maxRating, id: \.self) { index in
                SwiftUI.Image(systemName: index < animatedRating ? "star.fill" : "star")
                    .foregroundColor(.orange.opacity(1))
                    .font(.system(size: 10))
                    .scaleEffect(index < animatedRating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.8), value: animatedRating)
                    .shadow(color: .purple.opacity(0.35), radius: 5)
            }
        }
        .onAppear {
            animateStars()
        }
    }

    private func animateStars() {
        for i in 0...rating {
            DispatchQueue.main.asyncAfter(deadline: .now() + (0.2 * Double(i))) {
                withAnimation {
                    animatedRating = i
                }
            }
        }
    }
}
