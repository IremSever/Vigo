//
//  DetailCategoryType.swift
//  Vigo
//
//  Created by IREM SEVER on 25.02.2025.
//
enum DetailCategoryType: String, CaseIterable {
    case trailers
    case episodes
    case videos
    
    var displayName: String {
         switch self {
         case .trailers: return "Trailers"
         case .episodes: return "Episodes"
         case .videos: return "Videos"
         }
     }
}
