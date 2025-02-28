//
//  AlbumCell.swift
//  Vigo
//
//  Created by İrem Sever on 2.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct AlbumCell: View, ScrollingHelper {
    @ObservedObject var viewModel: HomeViewModel
    var widgetTitle: String?
    
    @State private var scrollProgressX: CGFloat = 0
    @State private var scrollOffsetY: CGFloat = 0
    @State private var scrollProxy: ScrollViewProxy?
    @State private var selectedIndex: Int = 1
    
    private var loopingData: [News] {
        let filteredItems = viewModel.homeModel?.data.flatMap { $0.news ?? [] }
            .filter { $0.external.starts(with: "video://") } ?? []
        guard filteredItems.count > 1 else { return filteredItems }
        return [filteredItems.last!] + filteredItems + [filteredItems.first!]
    }
    
    var body: some View {
        VStack {
            if let widgetTitle = widgetTitle {
                Text(widgetTitle)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 20) {
                        ForEach(loopingData.indices, id: \.self) { index in
                            let newsItem = loopingData[index]
                            
                            VStack(alignment: .center) {
                                if let imageUrl = URL(string: newsItem.image ?? "") {
                                    ZStack {
                                        WebImage(url: imageUrl)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 320, height: 450)
                                            .cornerRadius(20)
                                            .shadow(color: .purple.opacity(0.35), radius: 15, y: 12)
                                            .overlay(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear]),
                                                    startPoint: .bottom,
                                                    endPoint: .top
                                                )
                                                .cornerRadius(20)
                                            )
                                            .zIndex(0)
                                        
                                        VStack {
                                            Spacer()
                                            Text(newsItem.title ?? " ")
                                                .font(.system(size: 24, weight: .medium))
                                                .foregroundColor(.purple)
                                                .frame(width: 300, height: 22)
                                                .lineLimit(1)
                                                .zIndex(1)
                                            
                                            Text(newsItem.spot ?? "")
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(.white)
                                                .frame(width: 300, height: 16)
                                                .lineLimit(1)
                                                .padding(.bottom, 16)
                                                .zIndex(1)
                                        }
                                    }
                                }
                                BottomButton()
                                    .zIndex(0)
                            }
                            .frame(width: 320, height: 520)
                        }
                    }
                    .onAppear {
                        scrollProxy = proxy
                        scrollToIndex(selectedIndex, proxy: scrollProxy)
                    }
                }
            }
            .frame(height: 520)
            .background(
                Backdrop(
                    images: viewModel.getBackdropImages(),
                    scrollProgressX: $scrollProgressX,
                    scrollOffsetY: $scrollOffsetY
                )
            )
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        
                        withAnimation {
                            if value.translation.width < -threshold {
                                selectedIndex += 1
                            } else if value.translation.width > threshold {
                                selectedIndex -= 1
                            }
                            
                            if selectedIndex >= loopingData.count - 1 {
                                selectedIndex = 1
                            } else if selectedIndex <= 0 {
                                selectedIndex = loopingData.count - 2
                            }
                            
                            scrollToIndex(selectedIndex, proxy: scrollProxy)
                        }
                    }
            )
            .onScrollGeometryChange(for: CGFloat.self) {
                let offset = $0.contentOffset.x + $0.contentInsets.leading
                let width = $0.containerSize.width + 10
                return offset / width
            } action: { oldValue, newValue in
                scrollProgressX = newValue
            }
        }
        .frame(maxWidth: .infinity) // Ensure the cell doesn't overflow its parent width
        .zIndex(0)  // Set Z-index of the entire cell if needed
    }
}

