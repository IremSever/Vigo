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
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    @State private var scrollProgressX: CGFloat = 0
    @State private var scrollOffsetY: CGFloat = 0
    @State private var isUser: Bool = false
    var newsItem: News
    @State private var isExpanded = false
    
    @State private var rating: Int = 0
    @State private var showRatingPicker = false
    var currentRating: Int {
        favoritesViewModel.getRating(for: newsItem)
    }
    
    var starIcon: String {
        switch currentRating {
        case 0..<2: return "star"
        case 2..<4: return "star.leadinghalf.filled"
        case 4...5: return "star.fill"
        default: return "star"
        }
    }
    
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
                        .font(.exoBold(size: 24))
                        .foregroundColor(.white)
                    HStack(spacing: 20) {
                        
                        IconButton(
                            icon: favoritesViewModel.isFavorite(item: newsItem) ? "checkmark" : "plus"
                        ) {
                            favoritesViewModel.toggleFavorite(item: newsItem)
                        }
                        IconButton(icon: starIcon) {
                            withAnimation {
                                showRatingPicker.toggle()
                            }
                        }
                        IconButton(icon: "square.and.arrow.down") {}
                        IconButton(icon: "paperplane") {}
                    }
                    .padding(.bottom, 15)
                    if showRatingPicker {
                        HStack {
                            ForEach(1...5, id: \.self) { star in
                                SwiftUI.Image(systemName: star <= currentRating ? "star.fill" : "star")
                                    .foregroundColor(.orange.opacity(0.8))
                                    .onTapGesture {
                                        favoritesViewModel.updateRating(for: newsItem, rating: star)
                                        withAnimation {
                                            showRatingPicker = false
                                        }
                                    }
                            }
                        }
                        .padding(.bottom, 15)
                        .transition(.opacity)
                    }
                }
            }
   
            HStack {
                TagView(text: "epic")
                TagView(text: "tragedy")
                TagView(text: "drama")
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading) {
                Text(newsItem.detailDescription ?? "No description available.")
                    .foregroundColor(.white)
                    .font(.exoMedium(size: 14))
                    .lineLimit(isExpanded ? nil : 2)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                
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
                            .foregroundColor(Color.purple)
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                    }
                    .frame(maxWidth: .infinity)
                    
                    if isExpanded {
                        if let artists = newsItem.artist, !artists.isEmpty {
                            Text("Cast")
                                .font(.exoBold(size: 18))
                                .padding(.horizontal, 16)
                                .foregroundColor(.purple)
                            
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
                                                .font(.exoMedium(size: 14))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(Color.white)
                                                .frame(width: 115)
                                                .lineLimit(1)
                                            Text(artist.spot ?? "")
                                                .font(.exoRegular(size: 14))
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
                scrollOffsetY: $scrollOffsetY, isUser: $isUser
            )
            .ignoresSafeArea()
        )
        .edgesIgnoringSafeArea(.all)
    }
}
