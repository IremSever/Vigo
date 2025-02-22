//
//  DetailModel.swift
//  Vigo
//
//  Created by İrem Sever on 17.02.2025.
//

import Foundation
// MARK: - DetailModel
struct DetailModel: Codable {
    let meta: DetailMeta
    let data: [DetailData]
}

// MARK: - DetailData
struct DetailData: Codable {
    let config: DetailConfig
    let singleImage: DetailSingleImage?
    let detailDescription: DetailDescription?
    let videos: [DetailVideo]?
}

// MARK: - DetailConfig
struct DetailConfig: Codable {
    let widgetTitle: DetailWidgetTitle?
}

// MARK: - DetailWidgetTitle
struct DetailWidgetTitle: Codable {
    let text: String
}

// MARK: - DetailDescription
struct DetailDescription: Codable {
    let description: String?
}

// MARK: - DetailSingleImage
struct DetailSingleImage: Codable {
    let src: String
}

// MARK: - DetailVideo
struct DetailVideo: Codable {
    let external, id: String
    let image: String
    let imageBig: String
    let showAd: Bool
    let spot: String?
    let title: String
}

// MARK: - DetailMeta
struct DetailMeta: Codable {
    let statusCode: Int
    let message, description, brand, redirect: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand, redirect
    }
}
