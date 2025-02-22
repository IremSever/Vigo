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
                                        .frame(height: 110)
                                        .cornerRadius(20)
                                        .shadow(color: .purple.opacity(0.35), radius: 3)
                                }
                                VStack {
                                    Text(newsItem.title)
                                        .font(.system(size: 19))
                                        .foregroundColor(.purple)
                                        .frame(width: 150)
                                        .lineLimit(1)
                                    
                                    if let spot = newsItem.spot {
                                        Text(spot)
                                            .font(.system(size: 12))
                                            .foregroundColor(.white.opacity(1))
                                            .frame(width: 150)
                                            .lineLimit(1)
                                        
                                    } else {
                                        Text(" ")
                                            .font(.subheadline)
                                            .frame(width: 150, height: 18)
                                    }
                                }
                                
                            }
                            .frame(width: 200, height: 190 )
//                            .frame(height: 180)
                
//                        }
                    }
                }
            }.padding(.horizontal, 12)
        }
    }
}
