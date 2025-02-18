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
    let spot: String?
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
