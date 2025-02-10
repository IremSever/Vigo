//
//  CardCell.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardCell: View {
    @ObservedObject var viewModel: HomeViewModel
    var widgetTitle: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let homeData = viewModel.homeModel?.data {
                    let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
                    let newsItems = filteredSections.flatMap { $0.videos ?? [] }

                    ForEach(newsItems.indices, id: \.self) { index in
                        let newsItem = newsItems[index]
                        
                        NavigationLink(destination: DetailVC(viewModel: viewModel, selectedIndex: index, widgetTitle: widgetTitle)) {
                            VStack {
                                if let imageUrl = URL(string: newsItem.image) {
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                        .cornerRadius(20)
                                        .shadow(color: .purple.opacity(0.35), radius: 8)
                                        .padding(.top)
                                }
                                VStack {
                                    
                                    Text(newsItem.title)
                                        .font(.headline)
                                        .foregroundColor(.purple)
                                    
                                    if let spot = newsItem.spot {
                                        Text(spot)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }.padding(.bottom)
                                
                            }
                            .frame(height: 210)
                            .cornerRadius(20)
                        }
                    }
                }
            }
        }
    }
}
