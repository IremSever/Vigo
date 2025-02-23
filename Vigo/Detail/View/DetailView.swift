//
//  DetailVC.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI
struct DetailView: View {
    @ObservedObject var viewModel: HomeViewModel
    var newsItem: News

    var body: some View {
        CustomNav(app: "chevron.left", live: "", icon: "") {
            ScrollView {
                VStack {
                    CoverCell(viewModel: viewModel, newsItem: newsItem)
                        .frame(maxWidth: .infinity)
                    
                    if let trailers = newsItem.trailer, !trailers.isEmpty {
                        Text("Trailers:")
                            .font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(trailers, id: \.id) { trailer in
                                    VStack {
                                        if let trailerImageUrlString = trailer.image, let trailerImageUrl = URL(string: trailerImageUrlString) {
                                            WebImage(url: trailerImageUrl)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 120, height: 90)
                                                .cornerRadius(10)
                                        }
                                        Text(trailer.title ?? "Unknown Trailer")
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                 
                        }
                    }
                   
                    // Episodes section
                    if let episodes = newsItem.episode, !episodes.isEmpty {
                        Text("Episodes:")
                            .font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(episodes, id: \.id) { episode in
                                    VStack {
                                        if let episodeImageUrlString = episode.image, let episodeImageUrl = URL(string: episodeImageUrlString) {
                                            WebImage(url: episodeImageUrl)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 120, height: 90)
                                                .cornerRadius(10)
                                        }
                                        Text(episode.title ?? "Unknown Episode")
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                }
            }
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .scaleEffect(y: -1)
                .ignoresSafeArea(edges: .all)
        }
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.all)
        .clearNavigationBar()
    }
}
