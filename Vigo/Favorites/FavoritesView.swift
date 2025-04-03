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
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    UserCard()
                    RatedView(viewModel: viewModel)
                    FavoritesListView(viewModel: viewModel)
                    DownloadedView(viewModel: viewModel)
                }
            }
            .onAppear {
                viewModel.loadFavorites()
                viewModel.loadRatings()
                viewModel.loadDownload()
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
