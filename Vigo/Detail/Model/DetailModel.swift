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
    let description: DetailDescriptionData?
    let videos: [DetailVideo]?
}

// MARK: - DetailConfig
struct DetailConfig: Codable {
    let cell: DetailCell?
    let image: DetailImage?
    let widget: DetailWidget
    let detailDescription: DetailDescription?
    let spot, title: DetailSpot?
    let widgetMore: DetailWidgetMore?
    let widgetTitle: DetailWidgetTitle?
}

// MARK: - DetailCell
struct DetailCell: Codable {
    let bgColorDark, bgColorLight: String
    let borderColor: String?
    let borderIsActive: Bool?
    let radius: Int
    let ratio: Double
    let itemSpacer: Int?
}

// MARK: - DetailDescription
struct DetailDescription: Codable {
    let fontColorDark, fontColorLight: String
    let fontSize: Int
    let fontType: String
    let maxLines: Int
}

// MARK: - DetailImage
struct DetailImage: Codable {
    let radius: Int
    let size: String
    let weight: Double
}

// MARK: - DetailSpot
struct DetailSpot: Codable {
    let align: String?
    let fontColorDark, fontColorLight: String
    let fontSize: Int
    let fontType: String
    let isActive: Bool
    let maxLines: Int
    let isDynamicLines: Bool?
}

// MARK: -  DetailWidget
struct DetailWidget: Codable {
    let bgColorDark, bgColorLight: String?
    let columnCount: Int?
    let template: String
    let isPlaylist: Bool?
    let rowCount: Int?
    let type: String?
}

// MARK: - DetailWidgetMore
struct DetailWidgetMore: Codable {
    let bgColorDark, bgColorLight, external, fontColorDark: String
    let fontColorLight: String
    let fontSize: Int
    let fontType: String
    let isDynamicExternal: Bool
    let text: String
}

// MARK: - DetailWidgetTitle
struct DetailWidgetTitle: Codable {
    let fontColorDark, fontColorLight: String
    let fontSize: Int
    let fontType: String
    let spacer: Int
    let text: String
}

// MARK: - DetailDescription
struct DetailDescriptionData: Codable {
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
