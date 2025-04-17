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
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    var newsItem: News
    var buttonName: String = "chevron.left"

    var body: some View {
        CustomNav(app: buttonName, live: "", icon: "") {
            LazyVStack {
                CoverCell(viewModel: viewModel, favoritesViewModel: favoritesViewModel, newsItem: newsItem).padding(.bottom, 16)
                TrailerCell(newsItem: newsItem, favoritesViewModel: favoritesViewModel)
            }
            
        }
        .navigationBarHidden(true)
    }
}
