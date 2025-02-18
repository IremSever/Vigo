//
//  CategoryType.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//
//
//enum CategoryType: String, CaseIterable {
//    case trending
//    case classics
//    case shows
//
//    var url: String {
//        switch self {
//        case .trending:
//            return "https://api.tmgrup.com.tr/v2/link/752cc3f2dc"
//        case .classics:
//            return "https://api.tmgrup.com.tr/v2/link/ce11545b80"
//        case .shows:
//            return "https://api.tmgrup.com.tr/v2/link/d20b2ed128"
//        }
//    }
//    
//    var displayName: String {
//        switch self {
//        case .trending: return "Trending"
//        case .classics: return "Classics"
//        case .shows: return "Shows"
//        }
//    }
//}
enum CategoryType: String, CaseIterable {
    case trending
    case classics
    case shows

    var jsonFileName: String {
        switch self {
        case .trending:
            return "trending"
        case .classics:
            return "classics"
        case .shows:
            return "shows"
        }
    }
    
    var displayName: String {
        switch self {
        case .trending: return "Trending"
        case .classics: return "Classics"
        case .shows: return "Shows"
        }
    }
}
