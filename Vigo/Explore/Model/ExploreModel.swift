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
    let config: ExploreConfig
    let news: [ExploreNews]?
}
 
// MARK: - ExploreConfig
struct ExploreConfig: Codable {
    let cell: ExploreCell?
    let image: ExploreImage?
    let title: ExploreTitle?
    let widget: ExploreWidget?
}
 
// MARK: - ExploreCell
struct ExploreCell: Codable {
    let bgColorDark, bgColorLight, borderColor: String?
    let borderIsActive: Bool?
    let itemSpacer, radius, ratio: Int?
}
 
// MARK: - Image
struct ExploreImage: Codable {
    let padding: ExplorePadding
    let radius: Int
    let size: String
    let weight: Int
}
 
// MARK: - Padding
struct ExplorePadding: Codable {
    let bottom, paddingLeft, paddingRight, top: Int?
 
    enum CodingKeys: String, CodingKey {
        case bottom
        case paddingLeft = "left"
        case paddingRight = "right"
        case top
    }
}
 
// MARK: - Title
struct ExploreTitle: Codable {
    let align, fontColorDark, fontColorLight: String?
    let fontSize: Int?
    let fontType: String?
    let isActive: Bool?
    let maxLines: Int?
}
 
// MARK: - Widget
struct ExploreWidget: Codable {
    let bgColorDark, bgColorLight: String?
    let columnCount: Int?
    let padding: ExplorePadding?
    let template, type: String?
}
 
// MARK: - News
struct ExploreNews: Codable {
    let external: String?
    let image: String?
    let title: String?
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
