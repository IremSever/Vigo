//
//  CoverCell.swift
//  Vigo
//
//  Created by İrem Sever on 23.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct CoverCell: View {
    @ObservedObject var viewModel: HomeViewModel
    var newsItem: News
    @State private var isExpanded = false
    @State private var scrollProgressX: CGFloat = 0
    @State private var scrollOffsetY: CGFloat = 0
    
    
    var body: some View {
        VStack {
            ZStack {
                if let imageUrlString = newsItem.image, let imageUrl = URL(string: imageUrlString) {
                    WebImage(url: imageUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .purple.opacity(0.35), radius: 15, y: 12)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear]),
                                startPoint: .bottom,
                                endPoint: UnitPoint(x: 0.5, y: 0.5)
                            )
                            .cornerRadius(20)
                        )
                        .padding(.horizontal, 36)
                } else {
                    Color.black.edgesIgnoringSafeArea(.all)
                }
                
                VStack(alignment: .center, spacing: 12) {
                    Spacer()
                    Text(newsItem.title ?? "No Title")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                    HStack(spacing: 20) {
                        IconButton(icon: "plus")
                        IconButton(icon: "star")
                        IconButton(icon: "square.and.arrow.down")
                        IconButton(icon: "paperplane")
                    }.padding(.bottom, 15)
                }
            }
            
            HStack {
                TagView(text: "Series")
                TagView(text: "Drama")
                TagView(text: "Romance")
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading) {
                Text(newsItem.detailDescription ?? "No description available.")
                    .foregroundColor(.white)
                    .font(.body)
                    .lineLimit(isExpanded ? nil : 2)
                    .padding(.top, 8)
                    .padding(.horizontal, 12)
                
                if let description = newsItem.detailDescription, description.split(separator: " ").count > 20 {
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        SwiftUI.Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 12)
                            .foregroundColor(Color.purple.opacity(0.7))
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                    }
                    .frame(maxWidth: .infinity)
                    
                    if isExpanded {
                        if let artists = newsItem.artist, !artists.isEmpty {
                            Text("Artists")
                                .font(.headline)
                                .padding(.horizontal, 16)
                                .foregroundColor(.purple.opacity(0.7))
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(artists, id: \.title) { artist in
                                        VStack {
                                            if let artistImageUrlString = artist.image, let artistImageUrl = URL(string: artistImageUrlString) {
                                                WebImage(url: artistImageUrl)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 90, height: 90)
                                                    .cornerRadius(45)
                                            }
                                            Text(artist.title ?? "Unknown Artist")
                                                .font(.system(size: 11))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(Color.white)
                                            Text(artist.spot ?? "")
                                                .font(.system(size: 10))
                                                .foregroundColor(.purple)
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
        }
        .background(
             Backdrop(
                    images: viewModel.getBackdropImages(),
                    scrollProgressX: $scrollProgressX,
                    scrollOffsetY: $scrollOffsetY
                )
            .ignoresSafeArea()
        )
        .edgesIgnoringSafeArea(.all)
    }
}
