//
//  FavoritesViewModel.swift
//  Vigo
//
//  Created by IREM SEVER on 28.02.2025.
//


import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [String] = []
    func toggleFavorite(item: String) {
        if let index = favorites.firstIndex(of: item) {
            favorites.remove(at: index)
        } else {
            favorites.append(item) 
        }
    }

    func isFavorite(item: String) -> Bool {
        return favorites.contains(item)
    }
}
