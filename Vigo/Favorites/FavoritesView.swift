//
//  FavoritesVC.swift
//  Vigo
//
//  Created by İrem Sever on 5.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI
struct FavoritesView: View {
    @StateObject var favoritesViewModel = FavoritesViewModel()

    var body: some View {
        HStack {
            List {
                ForEach(favoritesViewModel.favoriteItems, id: \.title) { item in
                    HStack {
                        if let imageUrl = URL(string: item.image ?? "") {
                            WebImage(url: imageUrl)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                        }
                        Text(item.title ?? "Unknown")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
            }
            .background(Color.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .onAppear {
            favoritesViewModel.loadFavorites()
        }
    }
}

