//
//  ListCell.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListCell: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                if let homeData = viewModel.homeModel?.data {
                    ForEach(homeData, id: \.config.title.fontColorLight) { section in
                        if let newsList = section.news {
                            ForEach(newsList, id: \.title) { newsItem in
                                VStack {
                                    if let imageUrl = URL(string: newsItem.image ?? "") {
                                        WebImage(url: imageUrl)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 300)
                                            .cornerRadius(10)
                                    }
                                    VStack {
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
                            }
                        }
                    }
                }
            }
        }
    }
}
