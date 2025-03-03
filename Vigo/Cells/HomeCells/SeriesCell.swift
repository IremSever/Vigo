//
//  SeriesCell.swift
//  Vigo
//
//  Created by İrem Sever on 30.01.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct SeriesCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    var widgetTitle: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let homeData = viewModel.homeModel?.data {
                    let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
                    let newsItems = filteredSections.flatMap { $0.news ?? [] }

                    ForEach(newsItems.indices, id: \.self) { index in
                        let newsItem = newsItems[index]
                        
                        if newsItem.external.hasPrefix("apilink:///") {
                            let urlString = createDetailURL(from: newsItem.external)
                            NavigationLink(destination: DetailView(viewModel: viewModel, favoritesViewModel: favoritesViewModel, newsItem: newsItem)
                                            .navigationBarBackButtonHidden(true)
                                            .navigationBarItems(leading: CustomBackButton())) {
                                VStack {
                                    if let imageUrl = URL(string: newsItem.image ?? "") {
                                        WebImage(url: imageUrl)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 200)
                                            .cornerRadius(20)
                                            .shadow(color: .purple.opacity(0.35), radius: 3)
                                    }
                                }
                                .frame(width: 150, height: 220)
                                .cornerRadius(20)
                            }

                        }
                    }
                }
            }.padding(.horizontal, 12)
        }
    }

    private func createDetailURL(from external: String) -> String {
        let baseURL = "https://api.tmgrup.com.tr/"
        if let range = external.range(of: "apilink:///") {
            let path = external[range.upperBound...]
            return baseURL + path
        }
        return baseURL
    }
}
