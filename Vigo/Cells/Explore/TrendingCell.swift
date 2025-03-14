//
//  TrendingCell.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.

import SwiftUI
import SDWebImageSwiftUI

struct TrendingCell: View, ScrollingHelper {
    @ObservedObject var viewModel: ExploreViewModel
    @State private var selectedIndex: Int = 1
    @State private var scrollProxy: ScrollViewProxy?
    @State private var isExpanded = false

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
                    let selectedItem = loopingData[selectedIndex]

                    if let imageUrl = selectedItem.image, let validUrl = URL(string: imageUrl) {
                        WebImage(url: validUrl)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .blur(radius: 30, opaque: true)
                            .overlay {
                                Rectangle().fill(Color.black.opacity(0.35))
                            }
                            .mask {
                                LinearGradient(gradient: Gradient(colors: [
                                    .black, .gray, .gray, .gray, .white.opacity(0.5), .clear
                                ]), startPoint: .top, endPoint: .bottom)
                            }
                    }

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                ScrollViewReader { proxy in
                                    HStack {
                                        ForEach(loopingData.indices, id: \.self) { index in
                                            let newsItem = loopingData[index]
                                            let size = getSizeForIndex(index, selectedIndex: selectedIndex)
//                                            let yOffset = getYOffsetForIndex(index, selectedIndex: selectedIndex)

                                            VStack {
                                                if let imageUrl = newsItem.image, let validUrl = URL(string: imageUrl) {
                                                    WebImage(url: validUrl)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: isExpanded ? size / 2 : size, height: isExpanded ? size / 2 : size )
                                                        .clipShape(Circle())
                                                        .overlay(
                                                            Circle()
                                                                .stroke(selectedIndex == index ? Color.orange.opacity(0.3) : Color.purple.opacity(0.3), lineWidth: 5)
                                                                .shadow(color: selectedIndex == index ? .orange : .purple, radius: selectedIndex == index ? 3 : 1)
                                                        )
                                                       
                                                        .opacity(selectedIndex == index ? 1 : 0.8)
                                                }

                                                Text(newsItem.title ?? "")
                                                    .font(.exoBold(size: selectedIndex == index ? 24 : 15))
                                                    .foregroundColor(selectedIndex == index ? .orange : .purple.opacity(0.5))
                                                    .lineLimit(2)
                                                    .padding(.bottom, 8)

                                                if selectedIndex == index {
                                                    if isExpanded {
                                                        Text(newsItem.spot ?? "")
                                                            .font(.exoMedium(size: 14))
                                                            .foregroundColor(.white.opacity(0.8))
                                                            .multilineTextAlignment(.center)
                                                            .frame(alignment: .center)
                                                            .padding(.bottom, 8)
                                                    } else {
                                                        Text(newsItem.spot ?? "")
                                                            .font(.exoMedium(size: 14))
                                                            .foregroundColor(.white.opacity(0.8))
                                                            .multilineTextAlignment(.center)
                                                            .lineLimit(isExpanded ? nil : 10)
                                                            .fixedSize(horizontal: false, vertical: true)
                                                            .frame(maxHeight: isExpanded ? 300 : 200)
                                                         
                                                    }
                                                }
                                            }
                                            .frame(
                                                width: selectedIndex == index ? 250 : 150,
                                                height: isExpanded ? 600 : 720,
                                                alignment: .center
                                            )
                                            .offset(y: isExpanded ? 65
                                                    : 100)
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
                            .disabled(true)

                            if let selectedSpot = loopingData[selectedIndex].spot, selectedSpot.count > 300 {
                                Button(action: {
                                    withAnimation {
                                        isExpanded.toggle()
                                    }
                                }) {
                                    SwiftUI.Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                        .font(.headline).bold()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .foregroundColor(.orange)
                                }
                            }

                            if isExpanded {
                                VStack {
                                    Text("Videos")
                                        .font(.exoBold(size: 18))
                                        .padding(.horizontal, 16)
                                        .foregroundColor(.white)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        
                                        HStack {
                                            if let exploreVideos = loopingData[selectedIndex].exploreVideos {
                                                ForEach(exploreVideos, id: \.id) { video in
                                                    VStack {
                                                        if let imageUrl = video.image, let validUrl = URL(string: imageUrl) {
                                                            WebImage(url: validUrl)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: 150, height: 100)
                                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                        }
                                                        Text(video.title ?? "")
                                                            .font(.exoRegular(size: 14))
                                                            .foregroundColor(.orange)
                                                            .lineLimit(1)
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 16)
                                    }
                                    
                                    Text("Artists")
                                        .font(.exoBold(size: 18))
                                        .padding(.horizontal, 16)
                                        .foregroundColor(.white)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            if let artists = loopingData[selectedIndex].artists {
                                                ForEach(artists, id: \.title) { artist in
                                                    VStack {
                                                        if let imageUrl = artist.image, let validUrl = URL(string: imageUrl) {
                                                            WebImage(url: validUrl)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: 60, height: 60)
                                                                .cornerRadius(45)
                                                        }
                                                        Text(artist.title ?? "")
                                                            .font(.exoMedium(size: 14))
                                                            .foregroundColor(.orange)
                                                            .frame(width: 70)
                                                            .lineLimit(1)
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        .padding(.bottom, 16)
                                        .padding(.horizontal, 16)
                                    }
                                    
                                  
                                    Text("Recommended")
                                        .font(.exoBold(size: 18))
                                        .padding(.horizontal, 16)
                                        .foregroundColor(.white)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            let recommendedShows = loopingData.filter { show in
                                                guard let selectedTags = selectedItem.tags else { return false }
                                                guard let showTags = show.tags else { return false }

                                                let selectedTagTitles = selectedTags.compactMap { $0.title }
                                                let showTagTitles = showTags.compactMap { $0.title }

                                                return selectedTagTitles.contains { showTagTitles.contains($0) }
                                            }

                                            ForEach(recommendedShows, id: \.title) { recommendedShow in
                                                VStack {
                                                    if let imageUrl = recommendedShow.image, let validUrl = URL(string: imageUrl) {
                                                        WebImage(url: validUrl)
                                                            .resizable()
                                                            .frame(width: 130, height: 150)
                                                            .aspectRatio(contentMode: .fill)
                                                            .cornerRadius(20)
                                                    }
                                                    Text(recommendedShow.title ?? "")
                                                        .font(.exoRegular(size: 14))
                                                        .foregroundColor(.orange)
                                                        .frame(width: 100)
                                                        .lineLimit(1)
                                                }
                                            }

                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 110)
                                    }

                                    
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
            .onChange(of: selectedIndex) { _ in
                scrollToIndex(selectedIndex, proxy: scrollProxy)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

                

        
