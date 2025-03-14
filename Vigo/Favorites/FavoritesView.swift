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
                            
                            
                            Text("Rated")
                                .foregroundColor(.white)
                                .font(.exoBold(size: 18))
                                .padding(.horizontal, 16)
                            
                    
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(viewModel.ratings.keys.sorted(), id: \ .self) { key in
                                        if let item = viewModel.favoriteItems.first(where: { $0.title == key }), let imageUrl = URL(string: item.image ?? ""),   let seriesName = item.title {
                                            VStack {
                                                WebImage(url: imageUrl)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 120, height: 120)
                                                    .cornerRadius(20)
                                              
//                                              if let rating = viewModel.ratings[key] {
//                                                    VStack (alignment: .center){
////                                                        Text("\(rating)/5")
//                                                        Text("\(rating)")
//                                                            .foregroundColor(.orange)
//                                                            .font(.exoBold(size: 20))
////                                                            .rotationEffect(.degrees(270))
////                                                            .position(x: 95, y: 50)
//                                                    }
//                                                }
                                              
                                                Text(seriesName)
                                                    .foregroundColor(.purple)
                                                    .font(.exoMedium(size: 14))
                                                    .lineLimit(1)
                                                    .frame(width: 120)
                                                    .padding(.bottom, 5)

                                                
                                                if let rating = viewModel.ratings[key] {
                                                    VStack(alignment: .center) {
                                                        HStack(spacing: 2) {
                                                            ForEach(0..<rating, id: \.self) { _ in
                                                                SwiftUI.Image(systemName: "star.fill")
                                                                    .foregroundColor(.purple)
                                                                    .font(.system(size: 10))
                                                            }
                                                        }
                                                    }
                                                }

                                              
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }.padding(.bottom, 70)
                        }
                      
                    }
                    .onAppear {
                        viewModel.loadFavorites()
                        viewModel.loadRatings()
                        viewModel.loadDownload()
                    }
                }}}
        .background {
            Rectangle()
                .fill(.black.gradient)
                .scaleEffect(y: -1)
                .ignoresSafeArea(edges: .all)
        }
    }
}
