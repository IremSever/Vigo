//
//  BottomButton.swift
//  Vigo
//
//  Created by İrem Sever on 19.02.2025.
//

import SwiftUI

struct BottomButton: View {
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    var newsItem: News
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                favoritesViewModel.toggleFavorite(item: newsItem)
            }) {
                HStack {
                    SwiftUI.Image(systemName: favoritesViewModel.isFavorite(item: newsItem) ? "checkmark" : "plus")
                    Text(favoritesViewModel.isFavorite(item: newsItem) ? "Added" : "List")
                        .font(.exoRegular(size: 16))
                }
                .frame(width: 100, height: 40)
                .background(Color.purple.opacity(0.35))
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            
            Button(action: { print("Play tapped") }) {
                HStack {
                    SwiftUI.Image(systemName: "play.fill")
                    Text("Play")
                        .font(.exoRegular(size: 16))
                }
                .frame(width: 100, height: 40)
                .background(Color.purple.opacity(0.35))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding(.top, 10)
    }
}
