//
//  FavoritesViewModel.swift
//  Vigo
//
//  Created by IREM SEVER on 28.02.2025.
//
import SwiftUI
import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteItems: [News] = []
    @Published var ratings: [String: Int] = [:]  // Haber ID → Puan eşleşmesi
    private let favoritesKey = "favoriteItems"
    private let ratingsKey = "ratings"

    init() {
        loadFavorites()
        loadRatings()
    }

    /// **Favori ekleme veya çıkarma**
    func toggleFavorite(item: News) {
        if let index = favoriteItems.firstIndex(where: { $0.title == item.title }) {
            favoriteItems.remove(at: index)
        } else {
            favoriteItems.append(item)
        }
        saveFavorites()
    }

    func isFavorite(item: News) -> Bool {
        return favoriteItems.contains { $0.title == item.title }
    }

    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteItems) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesKey),
           let decodedItems = try? JSONDecoder().decode([News].self, from: savedData) {
            favoriteItems = decodedItems
        }
    }

    func updateRating(for item: News, rating: Int) {
        ratings[item.title ?? ""] = rating
        saveRatings()
        objectWillChange.send()
    }

    func getRating(for item: News) -> Int {
        return ratings[item.title ?? ""] ?? 0
    }

    func saveRatings() {
        if let encoded = try? JSONEncoder().encode(ratings) {
            UserDefaults.standard.set(encoded, forKey: ratingsKey)
        }
    }

    func loadRatings() {
        if let savedData = UserDefaults.standard.data(forKey: ratingsKey),
           let decodedRatings = try? JSONDecoder().decode([String: Int].self, from: savedData) {
            ratings = decodedRatings
        }
    }
}
