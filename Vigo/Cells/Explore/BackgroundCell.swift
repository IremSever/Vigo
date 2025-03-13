//
//  BackgroundCell.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct BackgroundCell: View {
    let imageUrl: String?

    var body: some View {
        WebImage(url: URL(string: imageUrl ?? ""))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.black.opacity(0.8), .clear]), startPoint: .top, endPoint: .bottom)
            )
            .edgesIgnoringSafeArea(.all)
    }
}
