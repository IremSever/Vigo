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
    var widgetTitle: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let homeData = viewModel.homeModel?.data {
                    let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
                    let newsItems = filteredSections.flatMap { $0.news ?? [] }

                    ForEach(newsItems.indices, id: \.self) { index in
                        let newsItem = newsItems[index]
                        
                        NavigationLink(destination: DetailVC(viewModel: viewModel, selectedIndex: index, widgetTitle: widgetTitle)) {
                            VStack {
                                if let imageUrl = URL(string: newsItem.image ?? "") {
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 300)
                                        .cornerRadius(20)
                                        .shadow(color: .purple.opacity(0.35), radius: 8)
                                }
                            }
                            .padding()
                            .frame(height: 350)
                            .cornerRadius(20)
                        }
                    }
                }
            }
        }
    }
}
