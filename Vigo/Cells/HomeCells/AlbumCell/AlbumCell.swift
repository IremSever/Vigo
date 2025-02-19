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
                                WebImage(url: imageUrl)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .containerRelativeFrame(.horizontal)
                                    .frame(height: 450)
                                    .cornerRadius(12)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(color: .purple.opacity(0.35), radius: 5)
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
