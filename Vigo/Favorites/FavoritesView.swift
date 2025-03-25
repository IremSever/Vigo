//
//  FavoritesVC.swift
//  Vigo
//
//  Created by İrem Sever on 5.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
    @StateObject var viewModel = FavoritesViewModel()
    
    var body: some View {
        ZStack {
            
            ScrollView (.vertical, showsIndicators: false)  {
                VStack{
                    UserCard()
                    ScrollView  {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Rated")
                                .foregroundColor(.white)
                                .font(.exoBold(size: 18))
                                .padding(.horizontal, 16)
                            
                            VStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(viewModel.ratings.keys.sorted(), id: \.self) { key in
                                            if let item = viewModel.favoriteItems.first(where: { $0.title == key }),
                                               let imageUrl = URL(string: item.image ?? ""),
                                               let seriesName = item.title,
                                               let rating = viewModel.ratings[key] {
                                                
                                                VStack {
                                                    ZStack {
                                                     
                                                        WebImage(url: imageUrl)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 140, height: 200)
                                                            .cornerRadius(20)
                                                            .shadow(color: .purple.opacity(0.35), radius: 5)
                                                            .overlay(
                                                                LinearGradient(
                                                                    gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]),
                                                                    startPoint: .bottom,
                                                                    endPoint: UnitPoint(x: 0.2, y: 0.2)
                                                                )
                                                                .cornerRadius(20)
                                                            )
                                                        StarRatingView(rating: rating).padding(.horizontal, 16)
                                                            .position(x: 140, y: 100)
                                                       
                                                    }
//                                                    Text(seriesName)
//                                                        .foregroundColor(.orange)
//                                                        .font(.exoSemiBold(size: 14))
//                                                        .lineLimit(1)
//                                                        .frame(width: 120)
//                                                        .padding(.bottom, 5)
//                                                    
                                                    
                                                }
                                            }
                                        }
                                    } .padding(.horizontal, 16)
                                }
                            }
                            Text("Favourites")
                                .foregroundColor(.white)
                                .font(.exoBold(size: 18))
                                .padding(.horizontal, 16)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(viewModel.favoriteItems, id: \ .title) { item in
                                        if let imageUrl = URL(string: item.image ?? "") {
                                            WebImage(url: imageUrl)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 150)
                                                .cornerRadius(20)
                                        }
                                    }
                                    
                                }
                                .padding(.horizontal, 12)
                            }
                            
                            Text("Downloaded")
                                .foregroundColor(.white)
                                .font(.exoBold(size: 18))
                                .padding(.horizontal, 16)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12){
                                    ForEach(viewModel.downloadedItems, id: \ .title) { item in
                                        if let imageUrl = URL(string: item.image ?? "") {
                                            VStack{
                                                WebImage(url: imageUrl)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 160, height: 120)
                                                    .cornerRadius(10)
                                                
                                                
                                                Text(item.title)
                                                    .font(.exoMedium(size: 14))
                                                    .foregroundColor(.purple.opacity(1))
                                                    .frame(width: 150)
                                                    .lineLimit(1)
                                            }
                                        }
                                    }
                                } .padding(.horizontal, 16)
                            }
                          
                       
                            .padding(.bottom, 70)
                            
                        }
                        
                    }
                    .onAppear {
                        viewModel.loadFavorites()
                        viewModel.loadRatings()
                        viewModel.loadDownload()
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
    }
}
