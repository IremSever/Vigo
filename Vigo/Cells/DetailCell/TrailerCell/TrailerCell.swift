//
//  TrailerCell.swift
//  Vigo
//
//  Created by İrem Sever on 23.02.2025.

import SwiftUI
import SDWebImageSwiftUI

struct TrailerCell: View {
    let newsItem: News
    @ObservedObject var viewModel = HomeViewModel()
    @State private var selectedTab: DetailCategoryType = .trailers
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(selectedCategory: $selectedTab, categories: DetailCategoryType.allCases, isExplore: false)
            
            switch selectedTab {
            case .trailers:
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
                                            .frame(width: 150)
                                            .cornerRadius(15)
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
                    .padding(.bottom, 66)
                }
                
            case .episodes:
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
                                            .frame(width: 150)
                                            .cornerRadius(20)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(episode.title ?? "Unknown Episode")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Text(episode.spot ?? "Unknown Episode")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                    .padding(.bottom, 66)
                }
                
            case .videos:
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
                                            .frame(width: 150)
                                            .cornerRadius(20)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(bestMoment.title ?? "Unknown Best Moment")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Text(bestMoment.spot ?? "Unknown Best Moment")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                    .padding(.bottom, 66)
                }
                
            }
        }
    }
}
