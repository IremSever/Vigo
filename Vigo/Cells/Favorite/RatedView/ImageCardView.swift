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
       ZStack {
            WebImage(url: imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 160)
                .cornerRadius(15)
                .shadow(color: .purple.opacity(0.35), radius: 2)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(1), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .center /*UnitPoint(x: 1, y: 0.8)*/
                    )
                    .cornerRadius(15)
                )
            StarRatingView(rating: Int(rating))
                .padding(.horizontal, 16)
                .padding(.top, 2)
                .position(x: 60, y: 145)
        }
    }
}
