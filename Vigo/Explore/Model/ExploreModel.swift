//
//  ExploreModel.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//

import SwiftUI
import Foundation
 
// MARK: - ExploreModel
struct ExploreModel: Codable {
    let meta: ExploreMeta
    let data: [ExploreData]
 
}
// MARK: - ExploreData
struct ExploreData: Codable {
    let news: [ExploreNews]?
}
 
// MARK: - News
struct ExploreNews: Codable {
    let external: String?
    let image: String?
    let title: String?
    let imdb: String?
    let liked: String?       
    let duration: String?
    let spot: String?
    let artists: [Artists]?
    let tags: [Tags]?
    let exploreVideos: [ExploreVideos]?
}

struct Artists: Codable {
    let image, spot, title: String?
}

struct Tags: Codable {
    let title: String?
}

struct ExploreVideos: Codable {
    let external, id, image, spot, title: String?
}


// MARK: - Meta
struct ExploreMeta: Codable {
    let statusCode: Int
    let message, description, brand, redirect: String
 
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand, redirect
    }
}
