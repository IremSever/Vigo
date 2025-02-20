//
//  TrendingCell.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct TrendingCell: View, ScrollingHelper {
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
                                        .black, .gray, .gray, .gray, .white.opacity(0.5), .clear
                                    ]), startPoint: .top, endPoint: .bottom)
                                }
                        }
                    }
                    
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { proxy in
                                HStack {
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
                                                            .stroke(selectedIndex == index ? Color.orange.opacity(0.5) : Color.purple.opacity(0.3), lineWidth: 5)
                                                            .shadow(color: selectedIndex == index ? .orange : .purple, radius: selectedIndex == index ? 5 : 2)
                                                    )
                                                    .padding(.bottom, 12)
                                                    .opacity(selectedIndex == index ? 1 : 0.8)
                                            }
                                            
                                            
                                            Text(newsItem.title ?? "")
                                                .font(.system(size: selectedIndex == index ? 24 : 15, weight: selectedIndex == index ? .bold : .regular))
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
                                                    .padding(.bottom, 12)
                                                
                                                Button(action: { print("Episodes tapped") }) {
                                           
                                                        SwiftUI.Image(systemName: "chevron.down")
                                                        .font(.headline).bold()
                                                    
                                                    .frame(width: 40, height: 40)
                                                    .background(Color.orange)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(20)
                                                }
                                        
                                                
                                            }
                                        }
                                        .frame(width: selectedIndex == index ? 250 : 150, height: 470)
                                        .offset(y: yOffset)
                                        .clipped()
                                    }
                                }
                                .padding(.horizontal)
                                .frame(minWidth: geometry.size.width, alignment: .center)
                                .onAppear {
                                    scrollProxy = proxy
                                    scrollToIndex(selectedIndex, proxy: scrollProxy)
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
}
