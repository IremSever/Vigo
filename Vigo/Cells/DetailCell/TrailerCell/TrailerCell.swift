//
//  TrailerCell.swift
//  Vigo
//
//  Created by İrem Sever on 23.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct TrailerCell: View {
    let newsItem: News
    @State private var selectedTab = "Trailers"

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            EpisodeSectionHeader(selectedTab: $selectedTab, tabs: ["Trailers", "Episodes", "Videos"])
            
            switch selectedTab {
            case "Trailers":
                if let trailers = newsItem.trailer, !trailers.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(trailers, id: \.id) { trailer in
                                HStack {
                                    if let trailerImageUrlString = trailer.image,
                                       let trailerImageUrl = URL(string: trailerImageUrlString) {
                                        WebImage(url: trailerImageUrl)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180)
                                            .cornerRadius(20)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(trailer.title ?? "Unknown Trailer")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Text(trailer.spot ?? "Unknown Trailer")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                   
                }

            case "Episodes":
                if let episodes = newsItem.episode, !episodes.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(episodes, id: \.id) { episode in
                                HStack {
                                    if let episodeImageUrlString = episode.image,
                                       let episodeImageUrl = URL(string: episodeImageUrlString) {
                                        WebImage(url: episodeImageUrl)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180)
                                            .cornerRadius(20)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(episode.title ?? "Unknown Episode")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Text(episode.spot ?? "Unknown Trailer")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                }

            case "Videos":
                if let bestMoments = newsItem.bestMoments, !bestMoments.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(bestMoments, id: \.id) { bestMoment in
                                HStack {
                                    if let bestMomentImageUrlString = bestMoment.image,
                                       let bestMomentImageUrl = URL(string: bestMomentImageUrlString) {
                                        WebImage(url: bestMomentImageUrl)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180)
                                            .cornerRadius(20)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(bestMoment.title ?? "Unknown bestMoment")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Text(bestMoment.spot ?? "Unknown bestMoment")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    
                    }
                }

            default:
                EmptyView()
            }
        }
    }
}
