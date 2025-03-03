//
//  HomeVC.swift
//  Vigo
//
//  Created by İrem Sever on 31.01.2025.
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var favoriteViewModel = FavoritesViewModel()
    var body: some View {
        NavigationView {
            CustomNav(app: "atv", live: " ", icon: "magnifyingglass") {
                LazyVStack(alignment: .leading) {
                    if let homeData = viewModel.homeModel?.data {
                        ForEach(homeData.indices, id: \.self) { index in
                            if let widgetTitle = viewModel.homeModel?.data[index].config.widgetTitle?.text, !widgetTitle.isEmpty {
                                Text(viewModel.formattedTurkishTitle(widgetTitle))
                                    .font(.system(size: 18).bold())
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.top)
                                    .frame(height: 20)
                            }

                            RowView(viewModel: viewModel, favoriteViewModel: favoriteViewModel, index: index)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            viewModel.fetchHomeData {}
        }
    }
}
