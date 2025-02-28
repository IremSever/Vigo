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
                    
                    let urlNewsItems = newsItems.filter { newsItem in
                        return newsItem.external.starts(with: "video://")
                    }
                    
                    let infiniteNewsItems = Array(repeating: urlNewsItems, count: 10).flatMap { $0 }
                    
                    ForEach(infiniteNewsItems.indices, id: \.self) { index in
                        let newsItem = infiniteNewsItems[index % urlNewsItems.count]
                        
                        VStack(alignment: .center) {
                            if let imageUrl = URL(string: newsItem.image ?? "") {
                                ZStack{
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .containerRelativeFrame(.horizontal)
                                        .frame(width: 320, height: 450, alignment: .center)
                                        .cornerRadius(12)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(color: .purple.opacity(0.35), radius: 15, y: 12)
                                        .overlay(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear]),
                                                startPoint: .bottom,
                                                endPoint: UnitPoint(x: 0.5, y: 0.5)
                                            )
                                            .cornerRadius(20)
                                        )
                                    VStack {
                                        Spacer()
                                        Text(newsItem.title ?? " ")
                                            .font(.system(size: 24, weight: .medium))
                                            .foregroundColor(.purple)
                                            .frame(width: 300, height: 22)
                                            .lineLimit(1)
                                        
                                        Text(newsItem.spot ?? "")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white)
                                            .frame(width: 300, height: 16)
                                            .lineLimit(1)
                                            .padding(.bottom, 16)
                                    }
                                }.frame(aligment: .center)
                            }
                            BottomButton()
                        }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .safeAreaPadding(15)
        .frame(height: 520)
        .background(
            Backdrop(
                images: viewModel.getBackdropImages(),
                scrollProgressX: $scrollProgressX,
                scrollOffsetY: $scrollOffsetY
            )
        )
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        .scrollIndicators(.hidden)
        .onAppear {
            scrollProgressX = 1
        }
        .onChange(of: scrollProgressX) { newIndex in
            currentIndex = Int(newIndex.rounded())
        }
        .onScrollGeometryChange(for: CGFloat.self) {
            let offset = $0.contentOffset.x + $0.contentInsets.leading
            let width = $0.containerSize.width + 10
            return offset / width
        } action: { oldValue, newValue in
            scrollProgressX = newValue
        }
    }
}
