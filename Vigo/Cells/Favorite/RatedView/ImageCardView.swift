//
//  ImageCardView.swift
//  Vigo
//
//  Created by IREM SEVER on 25.03.2025.
//



import SwiftUI
import SDWebImageSwiftUI

struct ImageCardView: View {
    let imageUrl: URL
    let rating: Double
    
    var body: some View {
        VStack {
            WebImage(url: imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 200)
                .cornerRadius(20)
                .shadow(color: .purple.opacity(0.35), radius: 5)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]),
                        startPoint: .bottom,
                        endPoint: UnitPoint(x: 0.2, y: 0.2)
                    )
                    .cornerRadius(20)
                )
            StarRatingView(rating: Int(rating))
                .padding(.horizontal, 16)
                .padding(.top, 2)
        }
    }
}
