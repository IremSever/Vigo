//
//  DownloadableItem.swift
//  Vigo
//
//  Created by IREM SEVER on 3.03.2025.
//
import Foundation
import SwiftUI
enum DownloadableItem: Codable, Identifiable {
    case news(News)
    case trailer(Trailer)
    case episode(Episode)
    case bestMoment(BestMoments)
    
    var id: String {
        switch self {
        case .news(let item): return item.title ?? UUID().uuidString
        case .trailer(let item): return item.title ?? UUID().uuidString
        case .episode(let item): return item.title ?? UUID().uuidString
        case .bestMoment(let item): return item.title ?? UUID().uuidString
        }
    }
    
    var title: String {
        switch self {
        case .news(let item): return item.title ?? "Unknown"
        case .trailer(let item): return item.title ?? "Unknown"
        case .episode(let item): return item.title ?? "Unknown"
        case .bestMoment(let item): return item.title ?? "Unknown"
        }
    }
    
    var image: String? {
        switch self {
        case .news(let item): return item.image
        case .trailer(let item): return item.image
        case .episode(let item): return item.image
        case .bestMoment(let item): return item.image
        }
    }
}
