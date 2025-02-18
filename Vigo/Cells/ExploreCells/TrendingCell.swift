//
//  TrendingCell.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct TrendingCell: View {
    @ObservedObject var viewModel: ExploreViewModel
    @State private var selectedIndex: Int = 1
    @State private var scrollProxy: ScrollViewProxy?
    
    private var loopingData: [ExploreNews] {
        guard let exploreData = viewModel.exploreModel?.data else { return [] }
        let allNewsItems = exploreData.flatMap { $0.news ?? [] }
        
        guard allNewsItems.count > 1 else { return allNewsItems }
        
        return [allNewsItems.last!] + allNewsItems + [allNewsItems.first!]
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if !loopingData.isEmpty {
                    if loopingData.indices.contains(selectedIndex) {
                        let selectedItem = loopingData[selectedIndex]
                        
                        if let imageUrl = selectedItem.image, let validUrl = URL(string: imageUrl) {
                            WebImage(url: validUrl)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .blur(radius: 30, opaque: true)
                                .overlay {
                                    Rectangle()
                                        .fill(Color.black.opacity(0.35))
                                }
                                .mask {
                                    LinearGradient(gradient: Gradient(colors: [
                                        .black, .black, .black, .black, .black.opacity(0.5), .clear
                                    ]), startPoint: .top, endPoint: .bottom)
                                }
                        }
                    }
                    
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { proxy in
                                HStack(spacing: 15) {
                                    ForEach(loopingData.indices, id: \.self) { index in
                                        let newsItem = loopingData[index]
                                        let size = getSizeForIndex(index, selectedIndex: selectedIndex)
                                        let yOffset = getYOffsetForIndex(index, selectedIndex: selectedIndex)
                                        
                                        VStack {
                                            if let imageUrl = newsItem.image, let validUrl = URL(string: imageUrl) {
                                                WebImage(url: validUrl)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: size, height: size)
                                                    .clipShape(Circle())
                                                    .overlay(
                                                        Circle()
                                                            .stroke(selectedIndex == index ? Color.orange.opacity(0.3) : Color.purple.opacity(0.1), lineWidth: 5)
                                                            .shadow(color: selectedIndex == index ? .orange : .purple, radius: selectedIndex == index ? 5 : 2)
                                                    )
                                                    .padding(.bottom, 10)
                                                    .opacity(selectedIndex == index ? 1 : 0.7)
                                            }
                                            
                                            
                                            Text(newsItem.title ?? "")
                                                .font(.system(size: selectedIndex == index ? 21 : 15, weight: selectedIndex == index ? .bold : .regular))
                                                .foregroundColor(selectedIndex == index ? .orange : .purple.opacity(0.5))
                                                .lineLimit(2)
                                                .padding(.bottom, 8)

                                            
                                            if selectedIndex == index {
                                                Text(newsItem.spot ?? "")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(.white.opacity(0.8))
                                                    .lineLimit(12)
                                                    .multilineTextAlignment(.center)
                                                    .frame(alignment: .center)
                                            }
                                        }
                                        .frame(width: selectedIndex == index ? 250 : 150, height: 450)
                                        .offset(y: yOffset)
                                        .clipped()
                                    }
                                }
                                .padding(.horizontal)
                                .frame(minWidth: geometry.size.width, alignment: .center)
                                .onAppear {
                                    scrollProxy = proxy
                                }
                            }
                        }
                    }
                }
            }
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
                            
                            if selectedIndex == loopingData.count - 1 {
                                selectedIndex = 1
                            } else if selectedIndex == 0 {
                                selectedIndex = loopingData.count - 2
                            }
                            
                            scrollToIndex(selectedIndex, proxy: scrollProxy)
                        }
                    }
            )
            .frame(width: geometry.size.width, height: geometry.size.height)
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private func getSizeForIndex(_ index: Int, selectedIndex: Int) -> CGFloat {
        let diff = abs(index - selectedIndex)
        switch diff {
        case 0: return 200
        case 1: return 100
        default: return 0
        }
    }
    
    private func getYOffsetForIndex(_ index: Int, selectedIndex: Int) -> CGFloat {
        let diff = abs(index - selectedIndex)
        switch diff {
        case 0: return -0
        case 1: return -0
        default: return 0
        }
    }
    
    private func scrollToIndex(_ index: Int, proxy: ScrollViewProxy?) {
        DispatchQueue.main.async {
            withAnimation {
                proxy?.scrollTo(index, anchor: .center)
            }
        }
    }
}
