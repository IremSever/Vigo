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
//                        
//                        NavigationLink(destination: DetailView(viewModel: viewModel, selectedIndex: index, widgetTitle: widgetTitle)) {
                            VStack {
                                if let imageUrl = URL(string: newsItem.image) {
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 120)
                                        .cornerRadius(25)
                                        .shadow(color: .purple.opacity(0.35), radius: 5)
                                        .padding(.top)
                                }
                                VStack {
                                    
                                    Text(newsItem.title)
                                        .font(.headline)
                                        .foregroundColor(.purple)
                                        .frame(width: 190)
                                        .lineLimit(1)
                                    
                                    if let spot = newsItem.spot {
                                        Text(spot)
                                            .font(.subheadline)
                                            .foregroundColor(.white.opacity(0.5))
                                            .frame(width: 150)
                                            .lineLimit(1)
                                    }
                                }
                                
                            }
                            .frame(width: 200, height: newsItem.spot != nil ? 190 : 170)
//                            .frame(height: 180)
               
//                        }
                    }
                }
            }.padding(.horizontal, 12)
        }
    }
}
