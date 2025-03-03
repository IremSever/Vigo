//
//  FavoritesVC.swift
//  Vigo
//
//  Created by İrem Sever on 5.02.2025.
//
//
//import SwiftUI
//import SDWebImageSwiftUI
//struct FavoritesView: View {
//    @StateObject var favoritesViewModel = FavoritesViewModel()
//
//    var body: some View {
//       VStack {
//           HStack {
//               List {
//                   ForEach(favoritesViewModel.favoriteItems, id: \.title) { item in
//                       HStack {
//                           if let imageUrl = URL(string: item.image ?? "") {
//                               WebImage(url: imageUrl)
//                                   .resizable()
//                                   .aspectRatio(contentMode: .fill)
//                                   .frame(height: 150)
//                                   .cornerRadius(20)
//                           }
////                           Text(item.title ?? "Unknown")
////                               .foregroundColor(.black)
////                               .font(.headline)
//                       }
//                   }
//               }
//            }
//           
//            if !favoritesViewModel.downloadedItems.isEmpty {
//      
//                    HStack {
//                        ForEach(favoritesViewModel.downloadedItems, id: \ .title) { item in
//                            VStack {
//                                if let imageUrl = URL(string: item.image ?? "") {
//                                    WebImage(url: imageUrl)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 120, height: 180)
//                                        .cornerRadius(10)
//                                }
//                                Text(item.title)
//                                    .foregroundColor(.white)
//                                    .font(.caption)
//                            }
//                        }
//                    }
//                
//            }
//           
//           if !favoritesViewModel.ratings.isEmpty {
//               HStack {
//                   ForEach(favoritesViewModel.ratings, id: \ .title) { item in
//                       VStack {
//                           if let imageUrl = URL(string: item.image ?? "") {
//                               WebImage(url: imageUrl)
//                                   .resizable()
//                                   .scaledToFit()
//                                   .frame(width: 120, height: 180)
//                                   .cornerRadius(10)
//                           }
//                           Text(item.title)
//                               .foregroundColor(.white)
//                               .font(.caption)
//                       }
//                   }
//               }
//           }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black)
//        .onAppear {
//            favoritesViewModel.loadFavorites()
//            favoritesViewModel.loadRatings()
//            favoritesViewModel.loadDownload()
//        }
//    }
//}
//your favorites
import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
    @StateObject var viewModel = FavoritesViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Your favourites")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.favoriteItems, id: \ .title) { item in
                            if let imageUrl = URL(string: item.image ?? "") {
                                WebImage(url: imageUrl)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 160, height: 220)
                                    .cornerRadius(20)
//                                
//                                Text("LIVE")
//                                    .font(.caption.bold())
//                                    .foregroundColor(.white)
//                                    .padding(5)
//                                    .background(Color.red)
//                                    .cornerRadius(5)
//                                    .padding(8)
//                                
//                                VStack {
//                                    Spacer()
//                                    Text(item.title)
//                                        .foregroundColor(.white)
//                                        .font(.headline.bold())
//                                        .padding()
//                                }
                            }
                        }
                        
                    }
                }
                
                Text("Watched Trailer")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(viewModel.downloadedItems, id: \ .title) { item in
                        if let imageUrl = URL(string: item.image ?? "") {
                            ZStack(alignment: .topLeading) {
                                WebImage(url: imageUrl)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 140, height: 80)
                                    .cornerRadius(10)
                                  
                                    .overlay(
                                        LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.7)]), startPoint: .center, endPoint: .bottom)
                                    )
                                
                              
                            }
                        }
                    }
                }
                
                Text("Rated")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.ratings.keys.sorted(), id: \ .self) { key in
                            if let item = viewModel.favoriteItems.first(where: { $0.title == key }), let imageUrl = URL(string: item.image ?? "") {
                                VStack {
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    
                                    
                                    if let rating = viewModel.ratings[key] {
                                        VStack (alignment: .center){
//                                            Text("Rating: \(rating)/5")
//                                                .foregroundColor(.white)
//                                                .font(.caption)
                                            Text("\(rating)/5")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            viewModel.loadFavorites()
            viewModel.loadRatings()
            viewModel.loadDownload()
        }
    }
}
