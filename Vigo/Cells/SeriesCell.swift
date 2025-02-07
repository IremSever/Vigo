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
    var widgetTitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let widgetTitle = widgetTitle {
                Text(widgetTitle)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if let homeData = viewModel.homeModel?.data {
                        let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
                        let newsItems = filteredSections.flatMap { $0.news ?? [] }

                        ForEach(newsItems, id: \.external) { newsItem in
                            VStack {
                                if let imageUrl = URL(string: newsItem.image ?? "") {
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                        .cornerRadius(12)
                                }
                                VStack(alignment: .leading) {
                                    Text(newsItem.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    if let spot = newsItem.spot {
                                        Text(spot)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding()
                            .frame(width: 200, height: 200)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .padding(.horizontal, 5)
                        }
                    }
                }
            }
        }
    }
}
