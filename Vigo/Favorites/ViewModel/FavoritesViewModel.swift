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
    @Published var ratings: [String: Int] = [:]
    @Published var downloadedItems: [DownloadableItem] = []
    private let favoritesKey = "favoriteItems"
    private let ratingsKey = "ratings"
    private let downloadedKey = "downloaded"
    
    init() {
        loadFavorites()
        loadRatings()
        loadDownload()
    }
    
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
    
    func downloadItem(_ item: Any) {
        let downloadableItem: DownloadableItem?
        
        if let newsItem = item as? News {
            downloadableItem = .news(newsItem)
        } else if let trailerItem = item as? Trailer {
            downloadableItem = .trailer(trailerItem)
        } else if let episodeItem = item as? Episode {
            downloadableItem = .episode(episodeItem)
        } else if let bestMomentItem = item as? BestMoments {
            downloadableItem = .bestMoment(bestMomentItem)
        } else {
            downloadableItem = nil
        }
        
        if let downloadableItem = downloadableItem, !downloadedItems.contains(where: { $0.id == downloadableItem.id }) {
            downloadedItems.append(downloadableItem)
            saveDownload()
        }
    }
    func isDownload(_ item: Any) -> Bool {
        let downloadableItem: DownloadableItem?

        if let newsItem = item as? News {
            downloadableItem = .news(newsItem)
        } else if let trailerItem = item as? Trailer {
            downloadableItem = .trailer(trailerItem)
        } else if let episodeItem = item as? Episode {
            downloadableItem = .episode(episodeItem)
        } else if let bestMomentItem = item as? BestMoments {
            downloadableItem = .bestMoment(bestMomentItem)
        } else {
            downloadableItem = nil
        }

        if let downloadableItem = downloadableItem {
            return downloadedItems.contains { $0.id == downloadableItem.id }
        }

        return false
    }

    
    func saveDownload() {
        if let encoded = try? JSONEncoder().encode(downloadedItems) {
            UserDefaults.standard.set(encoded, forKey: downloadedKey)
        }
    }
    
    func loadDownload() {
        if let savedData = UserDefaults.standard.data(forKey: downloadedKey),
           let decodedItems = try? JSONDecoder().decode([DownloadableItem].self, from: savedData) {
            downloadedItems = decodedItems
        }
        
    }
}
