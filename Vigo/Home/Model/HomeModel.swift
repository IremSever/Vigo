//
//  HomeModel.swift
//  Vigo
//
//  Created by İrem Sever on 30.01.2025.
//

import Foundation
import SwiftUI

// MARK: - HomeModel
struct HomeModel: Codable {
    let meta: Meta
    let data: [HomeData]
}

// MARK: - HomeData
struct HomeData: Codable {
    let config: HomeConfig
    let news: [News]?
    let streams: [Stream]?
    let videos: [Video]?
}

// MARK: - HomeConfig
struct HomeConfig: Codable {
    let cell: Cell
    let icon: Icon?
    let image: Image
    let indicator: Indicator?
    let spot: Spot?
    let title: Spot
    let widget: Widget
    let date: DateClass?
    let widgetTitle: WidgetTitle?
}

// MARK: - Cell
struct Cell: Codable {
    let bgColorDark, bgColorLight, borderColor: String
    let borderIsActive: Bool
    let radius: Int
    let ratio: Double
    let bgColorDarkDeselect, bgColorLightDeselect: String?
    let itemSpacer: Int?
    let shadowIsActive: Bool?
}

// MARK: - DateClass
struct DateClass: Codable {
    let fontColorDark, fontColorLight: String
    let fontSize: Int
    let fontType: String
    let isActive: Bool
    let maxLines: Int
}

// MARK: - Icon
struct Icon: Codable {
    let isActive: Bool
    let position: String
    let size: Int
    let type: String
}

// MARK: - Image
struct Image: Codable {
    let padding: Padding
    let radius: Int
    let size: String
    let weight: Double
}

// MARK: - Padding
struct Padding: Codable {
    let bottom, paddingLeft, paddingRight, top: Int

    enum CodingKeys: String, CodingKey {
        case bottom
        case paddingLeft = "left"
        case paddingRight = "right"
        case top
    }
}

// MARK: - Indicator
struct Indicator: Codable {
    let borderColor, borderColorDark: String
    let height: Int
    let isActive, isOverImage: Bool
    let selectedColor: String
    let showIndex: Bool
    let type, unselectedColor, unselectedColorDark: String
}

// MARK: - Spot
struct Spot: Codable {
    let align: String?
    let fontColorDark, fontColorLight: String
    let fontSize: Int
    let fontType: String
    let gradient: Bool?
    let isActive: Bool
    let maxLines: Int
    let scrollBehaviour: String?
    let isDynamicLines, checkShowTitle: Bool?
    let verticalAlignment: String?
}

// MARK: - Widget
struct Widget: Codable {
    let autoSlide: Bool?
    let bgColorDark, bgColorLight: String
    let columnCount: Int
    let infinityLoop: Bool?
    let interval: Int?
    let padding: Padding
    let scrollBehaviour: String?
    let template: String
    let type: String
    let decorationView: DecorationView?
    let rowCount: Int?
    let isPlaylist: Bool?
}

// MARK: - DecorationView
struct DecorationView: Codable {
    let isActive: Bool
    let type: String
}

// MARK: - WidgetTitle
struct WidgetTitle: Codable {
    let fontColorDark, fontColorLight: String
    let fontSize: Int
    let fontType: String
    let spacer: Int?
    let text: String
}

// MARK: - News
struct News: Codable {
    let external: String
    let image: String?
    let imageBig: String?
    let spot: String?
    let title: String?
}

// MARK: - Stream
struct Stream: Codable {
    let external: External
    let hour: String
    let isLive: Bool
    let image: String
    let minute, text, title: String
}


enum External: String, Codable {
    case selectedBroadcast = "selected://broadcast"
    case selectedLivestream = "selected://livestream"
}

// MARK: - Video
struct Video: Codable {
    let episode: Int?
    let external: String
    let image: String
    let season: Int?
    let showAd: Bool
    let spot: String?
    let title: String
    let videoTypeID: Int?
    let imageBig: String?

    enum CodingKeys: String, CodingKey {
        case episode, external, image, season, showAd, spot, title
        case videoTypeID = "videoTypeId"
        case imageBig
    }
}

// MARK: - Meta
struct Meta: Codable {
    let statusCode: Int
    let message, description, brand, redirect: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand, redirect
    }
}

