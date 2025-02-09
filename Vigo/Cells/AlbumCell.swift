//
//  AlbumCell.swift
//  Vigo
//
//  Created by İrem Sever on 2.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct AlbumCell: View {
    @ObservedObject var viewModel: HomeViewModel
    var widgetTitle: String?
    
    @State private var currentIndex = 1
    @State private var scrollProgressX: CGFloat = 0
    @State private var scrollOffsetY: CGFloat = 0

    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 20) {
                if let widgetTitle = widgetTitle {
                    Text(widgetTitle)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                
                if let homeData = viewModel.homeModel?.data {
                    let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
                    let newsItems = filteredSections.flatMap { $0.news ?? [] }
                    
                    let infiniteItems = [newsItems.last!] + newsItems + [newsItems.first!]
                    
                    ForEach(0..<infiniteItems.count, id: \.self) { index in
                        let newsItem = infiniteItems[index]
                        
                        NavigationLink(destination: DetailVC(viewModel: viewModel, selectedIndex: index, widgetTitle: widgetTitle ?? "")) {
                            VStack(alignment: .center) {
                                if let imageUrl = URL(string: newsItem.image ?? "") {
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .containerRelativeFrame(.horizontal)
                                        .frame(height: 450)
                                        .cornerRadius(12)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                                    
                                }
                                
                                VStack(alignment: .center, spacing: 5) {
                                    Text(newsItem.title)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.top, 8)
                                    
                                    if let spot = newsItem.spot {
                                        Text(spot)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                        }
                 
                    }
                }
                
            }
            .scrollTargetLayout()
        }
        .safeAreaPadding(15)
        .frame(height: 550)
        .background(Backdrop(images: viewModel.getBackdropImages(), scrollProgressX: $scrollProgressX, scrollOffsetY: $scrollOffsetY))
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        .scrollIndicators(.hidden)
    }
}
