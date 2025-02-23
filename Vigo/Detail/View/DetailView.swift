//
//  DetailVC.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//
import SwiftUI
//
//struct DetailView: View {
//    @ObservedObject var viewModel: DetailViewModel
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                if let detailModel = viewModel.detailModel {
//                    
//                    if let firstData = detailModel.data.first {
//                        
//     
//                        if let imageUrlString = firstData.singleImage?.src, let imageUrl = URL(string: imageUrlString) {
//                            AsyncImage(url: imageUrl) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFill()
//                                    .cornerRadius(10)
//                                    .shadow(radius: 5)
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .frame(maxWidth: .infinity, maxHeight: 500)
//                        }
//                        if let description = firstData.detailDescription?.description {
//                            Text(description)
//                                .font(.body)
//                                .foregroundColor(.gray)
//                                
//                                .padding()
//                        }
//                    }
//                }
//            }
//        }.padding()
//    }
//}
import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: HomeViewModel
    var newsItem: News

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image section
                if let imageUrlString = newsItem.image, let imageUrl = URL(string: imageUrlString) {
                    WebImage(url: imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(20)
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 200)
                        .cornerRadius(20)
                        .overlay(Text("No Image Available").foregroundColor(.white))
                }

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

                if let bestMoments = newsItem.bestMoments, !bestMoments.isEmpty {
                    Text("Best Moments:")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(bestMoments, id: \.id) { moment in
                                VStack {
                                    if let momentImageUrlString = moment.image, let momentImageUrl = URL(string: momentImageUrlString) {
                                        WebImage(url: momentImageUrl)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 90)
                                            .cornerRadius(10)
                                    }
                                    Text(moment.title ?? "Unknown Moment")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                }

                if let artists = newsItem.artist, !artists.isEmpty {
                    Text("Artists:")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(artists, id: \.title) { artist in
                                VStack {
                                    if let artistImageUrlString = artist.image, let artistImageUrl = URL(string: artistImageUrlString) {
                                        WebImage(url: artistImageUrl)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 90)
                                            .cornerRadius(10)
                                    }
                                    Text(artist.title ?? "Unknown Artist")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                    Text(artist.spot ?? "")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                } else {
                    Text("No Artists available")
                }

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
                        .padding(.horizontal, 12)
                    }
                }
            }
            .padding()
            .navigationTitle(newsItem.title ?? "Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
