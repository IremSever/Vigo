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
                        
                        // Directly check external as it's not Optional
                        if newsItem.external.hasPrefix("apilink:///") {
                            let urlString = createDetailURL(from: newsItem.external)
                            NavigationLink(destination: DetailView(viewModel: DetailViewModel(urlString: urlString))) {
                                VStack {
                                    if let imageUrl = URL(string: newsItem.image ?? "") {
                                        WebImage(url: imageUrl)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 150)
                                            .cornerRadius(20)
                                            .shadow(color: .purple.opacity(0.35), radius: 8)
                                    }
                                }
                                .frame(height: 185)
                                .cornerRadius(20)
                            }
                        }
                    }
                }
            }
        }
    }

    // Helper function to create the final URL
    private func createDetailURL(from external: String) -> String {
        let baseURL = "https://api.tmgrup.com.tr/"
        if let range = external.range(of: "apilink:///") {
            let path = external[range.upperBound...] // Extract everything after "apilink:///"
            return baseURL + path
        }
        return baseURL // Default fallback
    }
}
